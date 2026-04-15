# ⛽ Combustível Maputo — Guia de Configuração

Aplicação web open source para monitorização de combustível em Maputo em tempo real.

---

## 🚀 Configuração em 5 Minutos

### 1. Criar conta no Supabase (grátis)

1. Acede a [https://supabase.com](https://supabase.com)
2. Clica em **"Start your project"** → cria conta com GitHub ou email
3. Clica em **"New project"**
4. Escolhe um nome (ex: `combustivel-maputo`), uma password e a região `East Africa (Nairobi)` ou `West EU`
5. Aguarda ~2 minutos para o projeto inicializar

### 2. Criar a tabela `stations`

No painel do Supabase, vai a **SQL Editor** e executa este script:

```sql
-- Criar tabela de estações
CREATE TABLE stations (
  id          BIGSERIAL PRIMARY KEY,
  name        TEXT NOT NULL,
  location    TEXT NOT NULL,
  gasoleo     BOOLEAN DEFAULT false,
  gasolina    BOOLEAN DEFAULT false,
  gas         BOOLEAN DEFAULT false,
  queue       BOOLEAN DEFAULT false,
  lat         DOUBLE PRECISION,
  lng         DOUBLE PRECISION,
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Permitir leitura pública (sem login)
ALTER TABLE stations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leitura pública" ON stations
  FOR SELECT USING (true);

CREATE POLICY "Inserção pública" ON stations
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Atualização pública" ON stations
  FOR UPDATE USING (true);

-- Índice para pesquisa rápida por nome
CREATE INDEX idx_stations_name ON stations (LOWER(name));

-- Índice para ordenação por data
CREATE INDEX idx_stations_updated ON stations (updated_at DESC);
```

### 3. Obter as credenciais

No painel do Supabase:
- Vai a **Settings → API**
- Copia o **Project URL** (ex: `https://xyzxyz.supabase.co`)
- Copia a **anon public key** (chave longa que começa com `eyJ...`)

### 4. Configurar a aplicação

Abre o ficheiro `index.html` e substitui no topo do script:

```javascript
const SUPABASE_URL      = 'https://xyzxyz.supabase.co';  // ← o teu URL
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5...'; // ← a tua chave
```

---

## 🌐 Deploy (publicar online)

### Opção A — Netlify (recomendado, grátis)

1. Vai a [https://netlify.com](https://netlify.com) → cria conta grátis
2. Arrasta a pasta do projeto para a área de deploy
3. A app fica online em segundos com URL gratuito

### Opção B — Vercel (grátis)

1. Instala a CLI: `npm i -g vercel`
2. Na pasta do projeto: `vercel deploy`

### Opção C — GitHub Pages (grátis)

1. Cria um repositório público no GitHub
2. Faz upload dos ficheiros
3. Vai a **Settings → Pages → Deploy from branch** → seleciona `main`

---

## 🗺️ Adicionar coordenadas às estações

Para que as estações apareçam no mapa, preenche os campos **Latitude** e **Longitude** no formulário.

Referências de coordenadas em Maputo:
| Local                  | Latitude    | Longitude   |
|------------------------|-------------|-------------|
| Centro de Maputo       | -25.9692    | 32.5732     |
| Sommerschield          | -25.9625    | 32.5891     |
| Polana                 | -25.9739    | 32.5894     |
| Malhangalene           | -25.9680    | 32.5720     |
| Maxaquene              | -25.9550    | 32.5750     |
| Matola (centro)        | -25.9668    | 32.4618     |

Podes obter coordenadas exatas de qualquer local em [maps.google.com](https://maps.google.com) — clica com o botão direito no local → as coordenadas aparecem no topo do menu.

---

## 🛠️ Estrutura do Projeto

```
combustivel-maputo/
├── index.html    ← Aplicação completa (um único ficheiro)
└── README.md     ← Este guia
```

---

## ⚡ Funcionalidades

- ✅ Listagem em tempo real de estações
- ✅ Filtros por combustível e estado de fila
- ✅ Mapa interativo com Leaflet + OpenStreetMap
- ✅ Formulário de inserção e atualização
- ✅ Atualizações automáticas via Supabase Realtime
- ✅ Anti-spam simples (limite de 30s entre submissões)
- ✅ Modo de demonstração (funciona sem Supabase)
- ✅ Design responsivo para telemóvel
- ✅ Sem login ou autenticação

---

## 📄 Licença

MIT — livre para usar, modificar e distribuir.

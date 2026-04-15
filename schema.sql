-- ════════════════════════════════════════════════════════
-- Combustível Maputo — Schema SQL para Supabase
-- Copia e cola este script no SQL Editor do Supabase
-- ════════════════════════════════════════════════════════

-- 1. Criar tabela principal
CREATE TABLE IF NOT EXISTS stations (
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

-- 2. Habilitar Row Level Security
ALTER TABLE stations ENABLE ROW LEVEL SECURITY;

-- 3. Políticas de acesso público (sem autenticação)
CREATE POLICY "Leitura pública" ON stations
  FOR SELECT USING (true);

CREATE POLICY "Inserção pública" ON stations
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Atualização pública" ON stations
  FOR UPDATE USING (true);

-- 4. Índices para performance
CREATE INDEX IF NOT EXISTS idx_stations_name    ON stations (LOWER(name));
CREATE INDEX IF NOT EXISTS idx_stations_updated ON stations (updated_at DESC);

-- 5. (Opcional) Dados de exemplo para testar
INSERT INTO stations (name, location, gasoleo, gasolina, gas, queue, lat, lng)
VALUES
  ('Petromoc Sommerschield', 'Sommerschield, Maputo',  true,  false, true,  false, -25.9625, 32.5891),
  ('BP Polana',              'Polana, Maputo',          true,  true,  false, true,  -25.9739, 32.5894),
  ('Total Maxaquene',        'Maxaquene, Maputo',       true,  true,  true,  false, -25.9550, 32.5750),
  ('Galp Matola',            'Matola, Matola',          false, false, false, false, -25.9668, 32.4618);

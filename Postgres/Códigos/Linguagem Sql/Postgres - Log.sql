-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Configuração de Log no Postgres
-- ====================================================================================

-- Consulta Configuração -- 
SELECT * FROM pg_settings 
WHERE pg_settings.name ILIKE '<name_setting>';

-- Realiza a ativação do LOG no Postgres -- 
ALTER SYSTEM SET logging_collector = ON;

-- Parametriza para que o LOG seja gerado em formato CSV (stderr é o padrão) --
ALTER SYSTEM SET log_destination = 'csvlog';

-- Parametriza O Diretório de Geração do LOG (pg_log é o padrão) --
ALTER SYSTEM SET log_directory = 'pg_log';

-- Parametriza O nome do arquivo de log a ser gerado (postgresql-%Y-%m-%d_%H%M%S.log é o padrão)  - 0 desativa a limitação --
ALTER SYSTEM SET log_filename  = 'postgresql-%Y-%m-%d_%H%M%S.log';

-- Parametriza o tempo de vida de um arquivo (1D é o padrão) --
ALTER SYSTEM SET log_rotation_age  = '1D';

-- Parametriza o tamanho maximo de um arquivo individual (10240kb é o padrão) - 0 desativa a limitação --
ALTER SYSTEM SET log_rotation_size  = '1024';

-- Parametriza a sobrescrição dos arquivos de log (Padrão = OFF)
ALTER SYSTEM SET log_truncate_on_rotation  = 'off';

-- Parametriza qual conteúdo será logado (Padrão = none) - ddl , mod e all --
ALTER SYSTEM SET log_statement = 'none';

-- Parametriza se a duração das execuções serão logadas (OFF é o padrão - Não Logar duração) --
ALTER SYSTEM SET log_duration  = 'off';

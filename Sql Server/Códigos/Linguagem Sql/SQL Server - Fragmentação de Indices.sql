-- ====================================================================================
-- SGBD: <SQL Server>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Indice Análise de Fragmentação
-- ====================================================================================


-- Consultar a fragmentaçãoo média:
-- Entre 5% e 30%	Reorganizar o indice
-- Maior que 30%	Reconstruir o indice
select
    nome_tabela = object_name(b.object_id),
    nome_indice = name, 
    fragmentacao_media = avg_fragmentation_in_percent,
    script = case
        when avg_fragmentation_in_percent > 30 then 'alter index ' + name + ' on ' + object_name(b.object_id) + ' rebuild with (online = on)'
        when avg_fragmentation_in_percent >= 5 and avg_fragmentation_in_percent <= 30 then 'alter index ' + name + ' on ' + object_name(b.object_id) + ' reorganize'
    end
from sys.dm_db_index_physical_stats (db_id('PDS'), null, null, null, null) as a -- (Par�metros da fun��o: banco de dados, tabela, indice, parti��o f�sica, modo de analise: default, null, limited (limitado), sampled (amostra), detailed (detalhado))
join sys.indexes as b on a.object_id = b.object_id and a.index_id = b.index_id
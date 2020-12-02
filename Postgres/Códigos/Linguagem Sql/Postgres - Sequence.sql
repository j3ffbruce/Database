-- ====================================================================================
-- SGBD: <PostgreSQL>
-- Autor: Jefferson Alves Santos - https://github.com/j3ffbruce
-- Descrição: Práticas e Uso de Sequence
-- ====================================================================================

-- Definição: Objeto de gerenciamento de Sequenciais 


-- Estrutura de Criação de Sequence
 
-- CREATE [ TEMPORARY | TEMP ] SEQUENCE [ IF NOT EXISTS ] name [ INCREMENT [ BY ] increment ]
-- [ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
-- [ START [ WITH ] start ] [ CACHE cache ] [ [ NO ] CYCLE ]
-- [ OWNED BY { table_name.column_name | NONE } ]

-- Parâmetros

-- TEMPORARY ou TEMP
-- Se for especificado, o objeto de seqüência será criado somente para esta sessão, sendo automaticamente removido ao término da sessão. Enquanto existirem seqüências temporárias com o mesmo nome, as seqüências permanentes existentes não estarão visíveis (pela sessão), a não ser que sejam referenciadas por um nome qualificado pelo esquema.

-- nome
-- O nome (opcionalmente qualificado pelo esquema) da seqüência a ser criada.

-- incremento
-- A cláusula opcional INCREMENT BY incremento especifica o valor a ser adicionado ao valor corrente da seqüência para gerar o novo valor. Um valor positivo cria uma seqüência ascendente, enquanto um valor negativo cria uma seqüência descendente. O valor padrão é 1.

-- valor_mínimo NO MINVALUE
-- A cláusula opcional MINVALUE valor_mínimo determina o valor mínimo que a seqüência pode gerar. Se esta cláusula não for fornecida, ou for especificado NO MINVALUE, então serão utilizados os valores padrão. Os valores padrão são 1 e -263-1 para seqüências ascendentes e descendentes, respectivamente.

-- valor_máximo NO MAXVALUE
-- A cláusula opcional MAXVALUE valor_máximo determina o valor máximo que a seqüência pode gerar. Se esta cláusula não for fornecida, ou for especificado NO MAXVALUE, então serão utilizados os valores padrão. Os valores padrão são 263-1 e -1 para seqüências ascendentes e descendentes, respectivamente.

-- início
-- A cláusula opcional START WITH início permite a seqüência iniciar com qualquer valor. O valor inicial padrão é o valor_mínimo para seqüências ascendentes, e o valor_máximo para seqüências descendentes.

-- cache
-- A cláusula opcional CACHE cache especifica quantos números da seqüência devem ser pré-alocados e armazenados em memória para acesso mais rápido. O valor mínimo é 1 (somente um valor é gerado de cada vez, ou seja, sem cache), e este também é o valor padrão.

-- CYCLE / NO CYCLE
-- A opção CYCLE permite que a seqüência recomece quando for atingido o valor_máximo ou o valor_mínimo por uma seqüência ascendente ou descendente, respectivamente. Se o limite for atingido, o próximo número gerado será o valor_mínimo ou o valor_máximo, respectivamente.
--Se for especificado NO CYCLE, toda chamada a nextval após a seqüência ter atingido seu valor máximo retornará um erro. Se não for especificado nem CYCLE nem NO CYCLE, NO CYCLE é o padrão.

-- OWNED BY tabela.coluna
-- OWNED BY NONE
-- A opção OWNED BY faz com que a seqüência seja associada a uma determinada coluna de tabela, de tal forma que se a coluna (ou toda a tabela) for removida, a seqüência será automaticamente removida também. A tabela especificada deve possuir o mesmo dono e estar no mesmo esquema da seqüência. OWNED BY NONE, que é o padrão, especifica que não existe este tipo de associação.


-- Consulta de Todas as Sequences de uma Base de Dados
SELECT * FROM information_schema.sequences;

-- Consulta o Ultimo Valor da Sequencia
SELECT last_value FROM <sequence_name>;




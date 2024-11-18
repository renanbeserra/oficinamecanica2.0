-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS OficinaMecanica;
USE OficinaMecanica;


-- CRIAÇÃO DAS TABELAS

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nomeCliente VARCHAR(100) NOT NULL,
    cpf VARCHAR(45),
    rg VARCHAR(45)
);

-- Tabela Endereco
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100),
    numero INT,
    bairro VARCHAR(45),
    cidade VARCHAR(45),
    cep VARCHAR(45),
    complemento VARCHAR(45)
);

-- Tabela Cliente_has_Endereco (tabela de relacionamento)
CREATE TABLE Cliente_has_Endereco (
    Cliente_idCliente INT,
    Endereco_idEndereco INT,
    PRIMARY KEY (Cliente_idCliente, Endereco_idEndereco),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    codigo INT,
    nome VARCHAR(100),
    cpf VARCHAR(45),
    rg VARCHAR(45)
);

-- Tabela Telefone
CREATE TABLE Telefone (
    idTelefone INT AUTO_INCREMENT PRIMARY KEY,
    codigoPais VARCHAR(5),
    ddd VARCHAR(5),
    numero VARCHAR(45),
    Cliente_idCliente INT,
    Mecanico_idMecanico INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Tabela Email
CREATE TABLE Email (
    idEmail INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100),
    Cliente_idCliente INT,
    Mecanico_idMecanico INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(45),
    chassi VARCHAR(45),
    cor VARCHAR(45),
    modelo VARCHAR(45),
    potencia VARCHAR(45),
    ano VARCHAR(45),
    marca VARCHAR(45),
    descricao VARCHAR(500),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Especialidade
CREATE TABLE Especialidade (
    idEspecialidade INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100)
);

-- Tabela Especialidade_has_Mecanico (tabela de relacionamento)
CREATE TABLE Especialidade_has_Mecanico (
    Especialidade_idEspecialidade INT,
    Mecanico_idMecanico INT,
    PRIMARY KEY (Especialidade_idEspecialidade, Mecanico_idMecanico),
    FOREIGN KEY (Especialidade_idEspecialidade) REFERENCES Especialidade(idEspecialidade),
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Tabela Endereco_has_Mecanico (tabela de relacionamento)
CREATE TABLE Endereco_has_Mecanico (
    Endereco_idEndereco INT,
    Mecanico_idMecanico INT,
    PRIMARY KEY (Endereco_idEndereco, Mecanico_idMecanico),
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco),
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico)
);

-- Tabela OS (Ordem de Serviço)
CREATE TABLE OS (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    numero INT,
    dataEmissao DATE,
    dataConclusao DATE,
    status VARCHAR(500),
    valor FLOAT,
    Cliente_idCliente INT,
    Veiculo_idVeiculo INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Veiculo_idVeiculo) REFERENCES Veiculo(idVeiculo)
);

-- Tabela MaoDeObra
CREATE TABLE MaoDeObra (
    idMaoDeObra INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100),
    valor FLOAT
);

-- Tabela MaoDeObra_has_OS (tabela de relacionamento)
CREATE TABLE MaoDeObra_has_OS (
    MaoDeObra_idMaoDeObra INT,
    OS_idOS INT,
    PRIMARY KEY (MaoDeObra_idMaoDeObra, OS_idOS),
    FOREIGN KEY (MaoDeObra_idMaoDeObra) REFERENCES MaoDeObra(idMaoDeObra),
    FOREIGN KEY (OS_idOS) REFERENCES OS(idOS)
);

-- Tabela Peca
CREATE TABLE Peca (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(500),
    marca VARCHAR(45),
    valor FLOAT
);

-- Tabela OS_has_Peca (tabela de relacionamento)
CREATE TABLE OS_has_Peca (
    OS_idOS INT,
    Peca_idPeca INT,
    PRIMARY KEY (OS_idOS, Peca_idPeca),
    FOREIGN KEY (OS_idOS) REFERENCES OS(idOS),
    FOREIGN KEY (Peca_idPeca) REFERENCES Peca(idPeca)
);

-- Tabela OS_has_Mecanico (tabela de relacionamento)
CREATE TABLE OS_has_Mecanico (
    OS_idOS INT,
    Mecanico_idMecanico INT,
    dataEntrega DATE,
    PRIMARY KEY (OS_idOS, Mecanico_idMecanico),
    FOREIGN KEY (OS_idOS) REFERENCES OS(idOS),
    FOREIGN KEY (Mecanico_idMecanico) REFERENCES Mecanico(idMecanico)
);


-- INSERÇÃO DOS REGISTROS

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (nomeCliente, cpf, rg) VALUES 
('João Silva', '123.456.789-00', 'MG-12.345.678'),
('Maria Oliveira', '987.654.321-00', 'SP-87.654.321'),
('Carlos Pereira', '456.789.123-00', 'RJ-45.678.123'),
('Ana Souza', '654.321.987-00', 'ES-65.432.198'),
('Paulo Gomes', '789.123.456-00', 'PR-78.912.345');

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (logradouro, numero, bairro, cidade, cep, complemento) VALUES 
('Rua das Flores', 123, 'Centro', 'São Paulo', '01000-000', 'Apto 10'),
('Avenida Brasil', 456, 'Jardim', 'Rio de Janeiro', '20000-000', 'Bloco B'),
('Praça da Sé', 789, 'Sé', 'São Paulo', '03000-000', 'Edifício Central'),
('Rua Bahia', 321, 'Savassi', 'Belo Horizonte', '30110-000', 'Casa'),
('Alameda Santos', 654, 'Bela Vista', 'São Paulo', '01310-000', 'Cobertura');

-- Inserindo dados na tabela Cliente_has_Endereco
INSERT INTO Cliente_has_Endereco (Cliente_idCliente, Endereco_idEndereco) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela Mecanico
INSERT INTO Mecanico (codigo, nome, cpf, rg) VALUES 
(101, 'Marcos Lima', '333.444.555-66', 'MG-33.444.555'),
(102, 'Lucas Silva', '444.555.666-77', 'SP-44.555.666'),
(103, 'Renato Costa', '555.666.777-88', 'RJ-55.666.777'),
(104, 'Sérgio Alves', '666.777.888-99', 'RS-66.777.888'),
(105, 'Roberto Nunes', '777.888.999-00', 'PR-77.888.999');

-- Inserindo dados na tabela Telefone
INSERT INTO Telefone (codigoPais, ddd, numero, Cliente_idCliente) VALUES 
('+55', '11', '99999-0000', 1),
('+55', '21', '98888-1111', 2),
('+55', '31', '97777-2222', 3),
('+55', '41', '96666-3333', 4),
('+55', '11', '95555-4444', 5);

-- Inserindo dados na tabela Email
INSERT INTO Email (email, Cliente_idCliente) VALUES 
('joao.silva@example.com', 1),
('maria.oliveira@example.com', 2),
('carlos.pereira@example.com', 3),
('ana.souza@example.com', 4),
('paulo.gomes@example.com', 5);

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (placa, chassi, cor, modelo, potencia, ano, marca, descricao, Cliente_idCliente) VALUES 
('ZBC-9232', '9HGBGHJJFKV109775', 'Branco', 'City', '100cv', '2021', 'Honda', 'Carro em excelente estado', 1),
('AYZ-1672', '8HSXCV263RTY23159', 'Branco', 'Etios', '100cv', '2011', 'Toyota', 'Carro em excelente estado', 2),
('YEF-1014', '7HGCPOI633A654825', 'Branco', 'Ford ka', '100cv', '2012', 'Ford', 'Carro em excelente estado', 3),
('WHI-1452', '6JGBASDEX8A443123', 'Branco', 'Onix', '100cv', '2022', 'Chevrolet', 'Carro em excelente estado', 4),
('KKL-1892', '4TDDKQDM7JS987987', 'Branco', 'Gol', '100cv', '2023', 'Volkswagen', 'Carro em excelente estado', 5);

-- Inserindo dados na tabela Especialidade
INSERT INTO Especialidade (descricao) VALUES 
('Motor'),
('Transmissão'),
('Freios'),
('Suspensão'),
('Elétrica');

-- Inserindo dados na tabela Especialidade_has_Mecanico
INSERT INTO Especialidade_has_Mecanico (Especialidade_idEspecialidade, Mecanico_idMecanico) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela Endereco_has_Mecanico
INSERT INTO Endereco_has_Mecanico (Endereco_idEndereco, Mecanico_idMecanico) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela OS (Ordem de Serviço)
INSERT INTO OS (numero, dataEmissao, dataConclusao, status, valor, Cliente_idCliente, Veiculo_idVeiculo) VALUES 
(1001, '2024-11-01', '2024-11-05', 'Concluída', 1200.50, 1, 1),
(1002, '2024-11-02', '2024-11-06', 'Em andamento', 850.75, 2, 2),
(1003, '2024-11-03', '2024-11-07', 'Pendente', 430.00, 3, 3),
(1004, '2024-11-04', '2024-11-08', 'Concluída', 1500.00, 4, 4),
(1005, '2024-11-05', '2024-11-09', 'Cancelada', 0.00, 5, 5);

-- Inserindo dados na tabela MaoDeObra
INSERT INTO MaoDeObra (descricao, valor) VALUES 
('Troca de óleo', 150.00),
('Alinhamento e balanceamento', 200.00),
('Revisão completa', 800.00),
('Troca de pastilhas de freio', 350.00),
('Manutenção elétrica', 500.00);

-- Inserindo dados na tabela MaoDeObra_has_OS
INSERT INTO MaoDeObra_has_OS (MaoDeObra_idMaoDeObra, OS_idOS) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela Peca
INSERT INTO Peca (descricao, marca, valor) VALUES 
('Filtro de óleo', 'Bosch', 50.00),
('Bateria 60Ah', 'Moura', 450.00),
('Correia dentada', 'Gates', 120.00),
('Disco de freio', 'Brembo', 350.00),
('Velas de ignição', 'NGK', 200.00);

-- Inserindo dados na tabela OS_has_Peca
INSERT INTO OS_has_Peca (OS_idOS, Peca_idPeca) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela OS_has_Mecanico
INSERT INTO OS_has_Mecanico (OS_idOS, Mecanico_idMecanico, dataEntrega) VALUES 
(1, 1, '2024-11-05'),
(2, 2, '2024-11-06'),
(3, 3, '2024-11-07'),
(4, 4, '2024-11-08'),
(5, 5, '2024-11-09');


-- CONSULTAS 

-- Recuperações simples com SELECT Statement

-- Recuperar todos os clientes
SELECT * FROM Cliente;

-- Listar todos os veículos
SELECT idVeiculo, placa, modelo, marca, ano FROM Veiculo;

-- Exibir todas as ordens de serviço com seus respectivos valores
SELECT idOS, numero, dataEmissao, valor FROM OS;

-- Mostrar todas as peças cadastradas
SELECT idPeca, descricao, marca, valor FROM Peca;

-- Obter informações dos mecânicos
SELECT idMecanico, nome, cpf FROM Mecanico;


-- Filtros com WHERE Statement

-- Buscar clientes que possuem CPF iniciando com '123'
SELECT * FROM Cliente
WHERE cpf LIKE '123%';

-- Listar veículos da marca 'Toyota'
SELECT * FROM Veiculo
WHERE marca = 'Toyota';

-- Recuperar ordens de serviço com status 'Concluída'
SELECT * FROM OS
WHERE status = 'Concluída';

-- Obter peças que custam mais de 100 reais
SELECT * FROM Peca
WHERE valor > 100;

-- Exibir mecânicos especializados em 'Freios'
SELECT Mecanico.nome, Especialidade.descricao 
FROM Mecanico 
JOIN Especialidade_has_Mecanico ON Mecanico.idMecanico = Especialidade_has_Mecanico.Mecanico_idMecanico
JOIN Especialidade ON Especialidade.idEspecialidade = Especialidade_has_Mecanico.Especialidade_idEspecialidade
WHERE Especialidade.descricao = 'Freios';


-- Criação de atributos derivados

-- Calcular o tempo total (em dias) de conclusão das ordens de serviço
SELECT idOS, numero, DATEDIFF(dataConclusao, dataEmissao) AS diasParaConclusao
FROM OS;

-- Exibir o valor total (valor da ordem + mão de obra) para cada OS
SELECT OS.idOS, OS.valor AS valorOS, SUM(MaoDeObra.valor) AS totalMaoDeObra, 
       (OS.valor + IFNULL(SUM(MaoDeObra.valor), 0)) AS valorTotal
FROM OS
LEFT JOIN MaoDeObra_has_OS ON OS.idOS = MaoDeObra_has_OS.OS_idOS
LEFT JOIN MaoDeObra ON MaoDeObra.idMaoDeObra = MaoDeObra_has_OS.MaoDeObra_idMaoDeObra
GROUP BY OS.idOS;

-- Listar clientes com seus respectivos números de veículos
SELECT Cliente.nomeCliente, COUNT(Veiculo.idVeiculo) AS totalVeiculos
FROM Cliente
LEFT JOIN Veiculo ON Cliente.idCliente = Veiculo.Cliente_idCliente
GROUP BY Cliente.idCliente;


-- Ordenação dos dados com ORDER BY

-- Listar todos os clientes em ordem alfabética
SELECT * FROM Cliente
ORDER BY nomeCliente ASC;

-- Exibir os veículos mais novos primeiro
SELECT * FROM Veiculo
ORDER BY ano DESC;

-- Listar ordens de serviço por valor, do maior para o menor
SELECT * FROM OS
ORDER BY valor DESC;

-- Mostrar mecânicos em ordem de cadastro
SELECT * FROM Mecanico
ORDER BY idMecanico;

-- Listar peças por ordem crescente de valor
SELECT * FROM Peca
ORDER BY valor ASC;


-- Condições de filtros aos grupos – HAVING Statement

-- Exibir clientes que possuem mais de um veículo
SELECT Cliente.nomeCliente, COUNT(Veiculo.idVeiculo) AS totalVeiculos
FROM Cliente
JOIN Veiculo ON Cliente.idCliente = Veiculo.Cliente_idCliente
GROUP BY Cliente.idCliente
HAVING totalVeiculos > 1;

-- Listar mecânicos que trabalharam em mais de 3 ordens de serviço
SELECT Mecanico.nome, COUNT(OS_has_Mecanico.OS_idOS) AS totalOS
FROM Mecanico
JOIN OS_has_Mecanico ON Mecanico.idMecanico = OS_has_Mecanico.Mecanico_idMecanico
GROUP BY Mecanico.idMecanico
HAVING totalOS > 3;

-- Exibir peças cujo valor médio nas ordens de serviço é maior que 200
SELECT Peca.descricao, AVG(Peca.valor) AS mediaValor
FROM OS_has_Peca
JOIN Peca ON OS_has_Peca.Peca_idPeca = Peca.idPeca
GROUP BY Peca.idPeca
HAVING mediaValor > 200;


-- Junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

-- Listar todas as ordens de serviço junto com os detalhes do cliente e veículo
SELECT OS.idOS, OS.numero, OS.dataEmissao, Cliente.nomeCliente, Veiculo.modelo, Veiculo.placa
FROM OS
JOIN Cliente ON OS.Cliente_idCliente = Cliente.idCliente
JOIN Veiculo ON OS.Veiculo_idVeiculo = Veiculo.idVeiculo;

-- Exibir as ordens de serviço que envolvem peças específicas
SELECT OS.idOS, OS.numero, Peca.descricao, Peca.marca
FROM OS
JOIN OS_has_Peca ON OS.idOS = OS_has_Peca.OS_idOS
JOIN Peca ON OS_has_Peca.Peca_idPeca = Peca.idPeca;

-- Listar mecânicos e suas especialidades
SELECT Mecanico.nome AS nomeMecanico, Especialidade.descricao AS especialidade
FROM Mecanico
JOIN Especialidade_has_Mecanico ON Mecanico.idMecanico = Especialidade_has_Mecanico.Mecanico_idMecanico
JOIN Especialidade ON Especialidade.idEspecialidade = Especialidade_has_Mecanico.Especialidade_idEspecialidade;

-- Exibir todas as peças utilizadas nas ordens de serviço e seus respectivos clientes
SELECT Cliente.nomeCliente, Peca.descricao, OS.numero AS numeroOS
FROM Cliente
JOIN OS ON Cliente.idCliente = OS.Cliente_idCliente
JOIN OS_has_Peca ON OS.idOS = OS_has_Peca.OS_idOS
JOIN Peca ON OS_has_Peca.Peca_idPeca = Peca.idPeca;

-- Listar todas as ordens de serviço, mecânicos responsáveis e o tempo para conclusão
SELECT OS.idOS, OS.numero, Mecanico.nome AS nomeMecanico, 
       DATEDIFF(OS.dataConclusao, OS.dataEmissao) AS diasConclusao
FROM OS
JOIN OS_has_Mecanico ON OS.idOS = OS_has_Mecanico.OS_idOS
JOIN Mecanico ON OS_has_Mecanico.Mecanico_idMecanico = Mecanico.idMecanico;

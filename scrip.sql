-- Tabela: Usuario
CREATE TABLE Usuario (
    id_usuario VARCHAR(36) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('CLIENTE', 'TERAPEUTA') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    id_cliente VARCHAR(36) PRIMARY KEY,
    id_usuario VARCHAR(36),
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    data_nascimento DATE,
    endereco VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Terapeuta
CREATE TABLE Terapeuta (
    id_terapeuta VARCHAR(36) PRIMARY KEY,
    id_usuario VARCHAR(36),
    nome VARCHAR(255) NOT NULL,
    especialidades TEXT,
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    descricao_perfil TEXT,
    link_google_calendar VARCHAR(255),
    tempo_atendimento INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela: Consulta
CREATE TABLE Consulta (
    id_consulta VARCHAR(36) PRIMARY KEY,
    id_cliente VARCHAR(36),
    id_terapeuta VARCHAR(36),
    data_consulta DATETIME NOT NULL,
    duracao INT,
    status ENUM('AGENDADA', 'CANCELADA', 'CONCLUIDA') NOT NULL,
    link_reuniao VARCHAR(255),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_terapeuta) REFERENCES Terapeuta(id_terapeuta)
);

-- Tabela: Disponibilidade_Terapeuta
CREATE TABLE Disponibilidade_Terapeuta (
    id_disponibilidade VARCHAR(36) PRIMARY KEY,
    id_terapeuta VARCHAR(36),
    dia_semana ENUM('SEGUNDA', 'TERCA', 'QUARTA', 'QUINTA', 'SEXTA', 'SABADO', 'DOMINGO') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    FOREIGN KEY (id_terapeuta) REFERENCES Terapeuta(id_terapeuta)
);

-- Tabela: Fatura
CREATE TABLE Fatura (
    id_fatura VARCHAR(36) PRIMARY KEY,
    id_terapeuta VARCHAR(36),
    id_consulta VARCHAR(36),
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATETIME,
    status ENUM('PAGO', 'PENDENTE', 'CANCELADO') NOT NULL,
    FOREIGN KEY (id_terapeuta) REFERENCES Terapeuta(id_terapeuta),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela: Assinatura
CREATE TABLE Assinatura (
    id_assinatura VARCHAR(36) PRIMARY KEY,
    id_terapeuta VARCHAR(36),
    plano ENUM('BASICO', 'PROFISSIONAL', 'PREMIUM') NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    status ENUM('ATIVA', 'INATIVA', 'CANCELADA') NOT NULL,
    FOREIGN KEY (id_terapeuta) REFERENCES Terapeuta(id_terapeuta)
);

-- Tabela: Notificacao
CREATE TABLE Notificacao (
    id_notificacao VARCHAR(36) PRIMARY KEY,
    id_usuario VARCHAR(36),
    mensagem TEXT,
    tipo ENUM('AGENDAMENTO', 'CANCELAMENTO', 'PAGAMENTO', 'OUTRO') NOT NULL,
    lida BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

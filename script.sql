USE [master]
GO
/****** Object:  Database [OrdenesApp]    Script Date: 10/04/2025 04:34:07 a. m. ******/
CREATE DATABASE [OrdenesApp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OrdenesApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\OrdenesApp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OrdenesApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\OrdenesApp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OrdenesApp] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OrdenesApp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OrdenesApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OrdenesApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OrdenesApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OrdenesApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OrdenesApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [OrdenesApp] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [OrdenesApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OrdenesApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OrdenesApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OrdenesApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OrdenesApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OrdenesApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OrdenesApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OrdenesApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OrdenesApp] SET  ENABLE_BROKER 
GO
ALTER DATABASE [OrdenesApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OrdenesApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OrdenesApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OrdenesApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OrdenesApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OrdenesApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OrdenesApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OrdenesApp] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OrdenesApp] SET  MULTI_USER 
GO
ALTER DATABASE [OrdenesApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OrdenesApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OrdenesApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OrdenesApp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OrdenesApp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OrdenesApp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [OrdenesApp] SET QUERY_STORE = ON
GO
ALTER DATABASE [OrdenesApp] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [OrdenesApp]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 10/04/2025 04:34:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[EstadoID] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EstadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Municipios]    Script Date: 10/04/2025 04:34:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Municipios](
	[MunicipioID] [int] IDENTITY(1,1) NOT NULL,
	[EstadoID] [int] NOT NULL,
	[Municipio] [varchar](100) NOT NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MunicipioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdenesDeServicio]    Script Date: 10/04/2025 04:34:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenesDeServicio](
	[OrdenServicioID] [int] IDENTITY(1,1) NOT NULL,
	[MunicipioID] [int] NOT NULL,
	[Colonia] [varchar](100) NULL,
	[Domicilio] [varchar](100) NULL,
	[NumExterior] [varchar](20) NULL,
	[EntreCalles] [varchar](100) NULL,
	[FechaInicial] [date] NOT NULL,
	[FechaFinal] [date] NOT NULL,
	[Activo] [bit] NOT NULL,
	[UsuarioCreo] [int] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrdenServicioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 10/04/2025 04:34:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsID] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Contrasena] [varchar](255) NOT NULL,
	[Rol] [varchar](20) NOT NULL,
	[Activo] [bit] NOT NULL,
	[FechaCreacion] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Estados] ON 

INSERT [dbo].[Estados] ([EstadoID], [Estado], [Activo]) VALUES (1, N'Chiapas', 1)
INSERT [dbo].[Estados] ([EstadoID], [Estado], [Activo]) VALUES (2, N'Jalisco', 1)
SET IDENTITY_INSERT [dbo].[Estados] OFF
GO
SET IDENTITY_INSERT [dbo].[Municipios] ON 

INSERT [dbo].[Municipios] ([MunicipioID], [EstadoID], [Municipio], [Activo]) VALUES (1, 1, N'Tuxtla Gutiérrez', 1)
INSERT [dbo].[Municipios] ([MunicipioID], [EstadoID], [Municipio], [Activo]) VALUES (2, 1, N'San Cristóbal de las Casas', 1)
INSERT [dbo].[Municipios] ([MunicipioID], [EstadoID], [Municipio], [Activo]) VALUES (3, 2, N'Guadalajara', 1)
INSERT [dbo].[Municipios] ([MunicipioID], [EstadoID], [Municipio], [Activo]) VALUES (4, 2, N'Zapopan', 1)
SET IDENTITY_INSERT [dbo].[Municipios] OFF
GO
SET IDENTITY_INSERT [dbo].[OrdenesDeServicio] ON 

INSERT [dbo].[OrdenesDeServicio] ([OrdenServicioID], [MunicipioID], [Colonia], [Domicilio], [NumExterior], [EntreCalles], [FechaInicial], [FechaFinal], [Activo], [UsuarioCreo], [FechaCreacion]) VALUES (8, 1, N'copoya', N'3ra poniente', N'123', N'av central y primera sur', CAST(N'2025-04-10' AS Date), CAST(N'2025-04-12' AS Date), 0, 7, CAST(N'2025-04-10' AS Date))
INSERT [dbo].[OrdenesDeServicio] ([OrdenServicioID], [MunicipioID], [Colonia], [Domicilio], [NumExterior], [EntreCalles], [FechaInicial], [FechaFinal], [Activo], [UsuarioCreo], [FechaCreacion]) VALUES (9, 1, N'solorzano', N'jolones3', N'123', N'av central y primera sur', CAST(N'2025-04-11' AS Date), CAST(N'2025-04-12' AS Date), 1, 7, CAST(N'2025-04-10' AS Date))
INSERT [dbo].[OrdenesDeServicio] ([OrdenServicioID], [MunicipioID], [Colonia], [Domicilio], [NumExterior], [EntreCalles], [FechaInicial], [FechaFinal], [Activo], [UsuarioCreo], [FechaCreacion]) VALUES (10, 4, N'solorzano', N'asdasdadsa', N'12dfas', N'213ff44f44f', CAST(N'2025-04-12' AS Date), CAST(N'2025-04-13' AS Date), 1, 8, CAST(N'2025-04-10' AS Date))
SET IDENTITY_INSERT [dbo].[OrdenesDeServicio] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsID], [NombreUsuario], [Email], [Contrasena], [Rol], [Activo], [FechaCreacion]) VALUES (7, N'mario', N'mario@gmail.com', N'$2a$11$tXUImLZguF9LTxFXV32SiOrGjd7MHUB.G2dXqRm3b/ugjMNqF5l6K', N'admin', 1, CAST(N'2025-04-10' AS Date))
INSERT [dbo].[Usuarios] ([UsID], [NombreUsuario], [Email], [Contrasena], [Rol], [Activo], [FechaCreacion]) VALUES (8, N'prueba', N'prueba@gmail.com', N'$2a$11$vH196/K6TUbHm8P8W56L7eU3lSijd.VOazaaYofmxIbongi4zuDC6', N'usuario', 1, CAST(N'2025-04-10' AS Date))
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__A9D10534DF407FE1]    Script Date: 10/04/2025 04:34:07 a. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Estados] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Municipios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[OrdenesDeServicio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[OrdenesDeServicio] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Municipios]  WITH CHECK ADD FOREIGN KEY([EstadoID])
REFERENCES [dbo].[Estados] ([EstadoID])
GO
ALTER TABLE [dbo].[OrdenesDeServicio]  WITH CHECK ADD FOREIGN KEY([MunicipioID])
REFERENCES [dbo].[Municipios] ([MunicipioID])
GO
ALTER TABLE [dbo].[OrdenesDeServicio]  WITH CHECK ADD FOREIGN KEY([UsuarioCreo])
REFERENCES [dbo].[Usuarios] ([UsID])
GO
USE [master]
GO
ALTER DATABASE [OrdenesApp] SET  READ_WRITE 
GO

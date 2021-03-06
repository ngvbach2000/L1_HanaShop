USE [HanaShop]
GO
ALTER TABLE [dbo].[UserHistory] DROP CONSTRAINT [FK_UserHistory_User]
GO
ALTER TABLE [dbo].[BillDetail] DROP CONSTRAINT [FK_BillDetail_Bill]
GO
ALTER TABLE [dbo].[Bill] DROP CONSTRAINT [FK_Bill_User]
GO
/****** Object:  Table [dbo].[UserHistory]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP TABLE [dbo].[UserHistory]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP TABLE [dbo].[User]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP TABLE [dbo].[Food]
GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP TABLE [dbo].[BillDetail]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP TABLE [dbo].[Bill]
GO
USE [master]
GO
/****** Object:  Database [HanaShop]    Script Date: 1/20/2021 1:30:55 PM ******/
DROP DATABASE [HanaShop]
GO
/****** Object:  Database [HanaShop]    Script Date: 1/20/2021 1:30:55 PM ******/
CREATE DATABASE [HanaShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HanaShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HanaShop.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HanaShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HanaShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HanaShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HanaShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HanaShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HanaShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HanaShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HanaShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HanaShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HanaShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HanaShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HanaShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HanaShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HanaShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HanaShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HanaShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HanaShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HanaShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HanaShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HanaShop] SET RECOVERY FULL 
GO
ALTER DATABASE [HanaShop] SET  MULTI_USER 
GO
ALTER DATABASE [HanaShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HanaShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HanaShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HanaShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [HanaShop] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HanaShop', N'ON'
GO
USE [HanaShop]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 1/20/2021 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bill](
	[billID] [varchar](50) NOT NULL,
	[totalPrice] [float] NOT NULL,
	[dayOfPurchase] [date] NOT NULL,
	[username] [varchar](30) NOT NULL,
	[paymentOption] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[billID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 1/20/2021 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BillDetail](
	[billDetailID] [varchar](50) NOT NULL,
	[billID] [varchar](50) NOT NULL,
	[foodID] [varchar](20) NOT NULL,
	[foodName] [nvarchar](50) NOT NULL,
	[amount] [int] NOT NULL,
	[price] [float] NOT NULL,
	[total] [float] NOT NULL,
 CONSTRAINT [PK_BillDetail] PRIMARY KEY CLUSTERED 
(
	[billDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Food]    Script Date: 1/20/2021 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Food](
	[foodID] [varchar](20) NOT NULL,
	[foodname] [nvarchar](30) NOT NULL,
	[image] [varchar](100) NOT NULL,
	[description] [nvarchar](250) NOT NULL,
	[price] [float] NOT NULL,
	[createDate] [date] NOT NULL,
	[category] [nvarchar](30) NOT NULL,
	[status] [bit] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED 
(
	[foodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/20/2021 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[username] [varchar](30) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullname] [nvarchar](255) NOT NULL,
	[role] [varchar](50) NOT NULL,
	[address] [nvarchar](250) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](11) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserHistory]    Script Date: 1/20/2021 1:30:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserHistory](
	[HistoryID] [nvarchar](20) NOT NULL,
	[username] [varchar](30) NOT NULL,
	[content] [nvarchar](200) NOT NULL,
	[date] [date] NOT NULL,
 CONSTRAINT [PK_UserHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210117113125', 0.5, CAST(N'2021-01-17' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210118084609', 21.600000381469727, CAST(N'2021-01-18' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210118142434', 18.399999618530273, CAST(N'2021-01-18' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210119140239', 17, CAST(N'2021-01-19' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210119145639', 10, CAST(N'2021-01-19' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210120095220', 7.3000001907348633, CAST(N'2021-01-20' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210120122111', 93, CAST(N'2021-01-20' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'107234487794169521418_20210120122123', 3, CAST(N'2021-01-20' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210112154047', 107, CAST(N'2021-01-12' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210112154146', 6.8000001907348633, CAST(N'2021-01-12' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210112204132', 4.5, CAST(N'2021-01-12' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210112204754', 1.2000000476837158, CAST(N'2021-01-12' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210113093135', 2.4000000953674316, CAST(N'2021-01-13' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'20210115123801', 50.299999237060547, CAST(N'2021-01-15' AS Date), N'107234487794169521418', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210117094344', 20.299999237060547, CAST(N'2021-01-17' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210117095835', 9.8999996185302734, CAST(N'2021-01-17' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210117104915', 10.399999618530273, CAST(N'2021-01-17' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210117110600', 3.7999999523162842, CAST(N'2021-01-17' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210118084854', 4, CAST(N'2021-01-18' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210118130719', 1, CAST(N'2021-01-18' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210118142827', 2, CAST(N'2021-01-18' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'bachnv_20210120132230', 59.400001525878906, CAST(N'2021-01-20' AS Date), N'bachnv', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'cust_20210116142401', 12.399999618530273, CAST(N'2021-01-16' AS Date), N'cust', N'Cash on delivery (COD)')
INSERT [dbo].[Bill] ([billID], [totalPrice], [dayOfPurchase], [username], [paymentOption]) VALUES (N'Nguyetiu_20210118201444', 7.5, CAST(N'2021-01-18' AS Date), N'Nguyetiu', N'Cash on delivery (COD)')
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101121540470', N'20210112154047', N'10', N'Beef Burger B', 20, 2.5, 50)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101121540471', N'20210112154047', N'9', N'20 chicken wings fried', 1, 15, 15)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101121540472', N'20210112154047', N'3', N'Cheese Cake', 20, 2.0999999046325684, 42)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101121541460', N'20210112154146', N'6', N'Three chicken fried', 1, 2.2999999523162842, 2.2999999523162842)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101121541461', N'20210112154146', N'1', N'Americano', 3, 1.5, 4.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101122041320', N'20210112204132', N'10', N'Beef Burger B', 1, 2.5, 2.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101122041321', N'20210112204132', N'11', N'Beef Burger S', 1, 2, 2)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101122047540', N'20210112204754', N'4', N'Ice Milk Coffee', 1, 1.2000000476837158, 1.2000000476837158)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101130931350', N'20210113093135', N'13', N'Chickken Burger', 1, 2.4000000953674316, 2.4000000953674316)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238010', N'20210115123801', N'15', N'Chocolate Cookie', 4, 0.5, 2)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238011', N'20210115123801', N'16', N'Milk Cream Tea', 1, 2.9000000953674316, 2.9000000953674316)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238012', N'20210115123801', N'14', N'Chocolate Cake', 4, 1.8999999761581421, 7.5999999046325684)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238013', N'20210115123801', N'13', N'Chickken Burger', 2, 2.4000000953674316, 4.8000001907348633)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238014', N'20210115123801', N'3', N'Cheese Cake', 3, 2.0999999046325684, 6.3000001907348633)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238015', N'20210115123801', N'12', N'Chese Beef Burger', 2, 2.5999999046325684, 5.1999998092651367)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238016', N'20210115123801', N'11', N'Beef Burger S', 1, 2, 2)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238017', N'20210115123801', N'4', N'Ice Milk Coffee', 5, 1.2000000476837158, 6)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238018', N'20210115123801', N'1', N'Americano', 1, 1.5, 1.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101151238019', N'20210115123801', N'2', N'One chicken fried', 12, 1, 12)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101161424010', N'cust_20210116142401', N'14', N'Chocolate Cake', 4, 1.8999999761581421, 7.5999999046325684)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101161424011', N'cust_20210116142401', N'13', N'Chickken Burger', 2, 2.4000000953674316, 4.8000001907348633)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170943440', N'bachnv_20210117094344', N'18', N'Banana Fuffin', 5, 1.5, 7.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170943441', N'bachnv_20210117094344', N'22', N'ConoRoon Cake', 2, 0.89999997615814209, 1.7999999523162842)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170943442', N'bachnv_20210117094344', N'16', N'Milk Cream Tea', 3, 2.9000000953674316, 8.6999998092651367)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170943443', N'bachnv_20210117094344', N'6', N'Three chicken fried', 1, 2.2999999523162842, 2.2999999523162842)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170958350', N'bachnv_20210117095835', N'25', N'Danasi Water', 11, 0.5, 5.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101170958351', N'bachnv_20210117095835', N'19', N'Caramel Ice Blended', 2, 2.2000000476837158, 4.4000000953674316)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101171049150', N'bachnv_20210117104915', N'20', N'Chicken Rice', 2, 3, 6)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101171049151', N'bachnv_20210117104915', N'19', N'Caramel Ice Blended', 2, 2.2000000476837158, 4.4000000953674316)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101171106000', N'bachnv_20210117110600', N'17', N'Peach Tea', 2, 1.8999999761581421, 3.7999999523162842)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101171131250', N'107234487794169521418_20210117113125', N'23', N'Coke Light', 1, 0.5, 0.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101180846090', N'107234487794169521418_20210118084609', N'15', N'Chocolate Cookie', 9, 0.5, 4.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101180846091', N'107234487794169521418_20210118084609', N'18', N'Banana Fuffin', 5, 1.5, 7.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101180846092', N'107234487794169521418_20210118084609', N'28', N'Matcha Ice Blended', 3, 3.2000000476837158, 9.6000003814697266)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101180848540', N'bachnv_20210118084854', N'7', N'Five chicken frieds', 1, 4, 4)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101181307190', N'bachnv_20210118130719', N'24', N'Macaroon Cake', 2, 0.5, 1)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101181424340', N'107234487794169521418_20210118142434', N'28', N'Matcha Ice Blended', 2, 3.2000000476837158, 6.4000000953674316)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101181424341', N'107234487794169521418_20210118142434', N'30', N'Pork Rice', 4, 3, 12)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101181428270', N'bachnv_20210118142827', N'37', N'Hot Matcha', 1, 2, 2)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101182014440', N'Nguyetiu_20210118201444', N'30', N'Pork Rice', 2, 3, 6)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101182014441', N'Nguyetiu_20210118201444', N'43', N'Milo Milk', 1, 0.5, 0.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101182014442', N'Nguyetiu_20210118201444', N'35', N'Ice-Cream', 1, 1, 1)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101191402390', N'107234487794169521418_20210119140239', N'30', N'Pork Rice', 3, 3, 9)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101191402391', N'107234487794169521418_20210119140239', N'36', N'Hot Latte', 4, 2, 8)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101191456390', N'107234487794169521418_20210119145639', N'44', N'TH True Milk', 20, 0.5, 10)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101200952200', N'107234487794169521418_20210120095220', N'44', N'TH True Milk', 1, 0.5, 0.5)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101200952201', N'107234487794169521418_20210120095220', N'35', N'Ice-Cream', 1, 1, 1)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101200952202', N'107234487794169521418_20210120095220', N'34', N'Choco Coffee', 1, 3.7999999523162842, 3.7999999523162842)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101200952203', N'107234487794169521418_20210120095220', N'26', N'Fish Burger', 1, 2, 2)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101201221110', N'107234487794169521418_20210120122111', N'31', N'Pork Egg Rice', 30, 3.0999999046325684, 93)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101201221230', N'107234487794169521418_20210120122123', N'30', N'Pork Rice', 1, 3, 3)
INSERT [dbo].[BillDetail] ([billDetailID], [billID], [foodID], [foodName], [amount], [price], [total]) VALUES (N'202101201322300', N'bachnv_20210120132230', N'19', N'Caramel Ice Blended', 27, 2.2000000476837158, 59.400001525878906)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'1', N'Americano', N'image/americano.png', N'Hot Coffee American', 1.6000000238418579, CAST(N'2020-01-07' AS Date), N'Coffee', 1, 47)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'10', N'Beef Burger B', N'image/beef_burger.png', N'Beef Burger big size', 2.5, CAST(N'2021-01-11' AS Date), N'Burger', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'11', N'Beef Burger S', N'image/beef_mcroyal_deluxe.png', N'Beef Burger size Smail', 2, CAST(N'2021-01-11' AS Date), N'Burger', 1, 35)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'12', N'Chese Beef Burger', N'image/cheese-burger-beef.png', N'Chese Beef Burger', 2.5999999046325684, CAST(N'2021-01-11' AS Date), N'Burger', 1, 28)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'13', N'Chickken Burger', N'image/Chicken_burger.png', N'Chicken Burger', 2.4000000953674316, CAST(N'2021-01-12' AS Date), N'Burger', 1, 10)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'14', N'Chocolate Cake', N'image/CHOCO-BROWNIE.png', N'Chocolate Cake', 1.8999999761581421, CAST(N'2021-01-13' AS Date), N'Cake', 1, 27)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'15', N'Chocolate Cookie', N'image/CHOCOLATE-CHIP-COOKIE.png', N'Chocolate Cookie', 0.5, CAST(N'2021-01-13' AS Date), N'Cookie', 1, 87)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'16', N'Milk Cream Tea', N'image/CSO_MilkCreamTea_S.png', N'Milk Cream Tea', 2.9000000953674316, CAST(N'2021-01-13' AS Date), N'Tea', 1, 26)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'17', N'Peach Tea', N'image/CSO_PeachTea_S.png', N'Peach Tea', 1.8999999761581421, CAST(N'2021-01-14' AS Date), N'Tea', 1, 18)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'18', N'Banana Fuffin', N'image/BANANA-MUFFIN.png', N'Banana Fuffin', 1.5099999904632568, CAST(N'2021-01-17' AS Date), N'Cake', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'19', N'Caramel Ice Blended', N'image/caramelfrappe.png', N'Caramel Ice Blended', 2.2000000476837158, CAST(N'2021-01-17' AS Date), N'Ice Blended', 1, 19)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'2', N'One chicken fried', N'image/1-ga-ran.png', N'One yummy chicken fried', 1.1000000238418579, CAST(N'2021-01-06' AS Date), N'Chicken Fried', 0, 20)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'20', N'Chicken Rice', N'image/chicken_rice.png', N'Chicken with Rice', 3, CAST(N'2021-01-17' AS Date), N'Rice', 1, 30)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'21', N'Choco Brownie', N'image/CHOCO-BROWNIE.png', N'Choco Brownie', 1.6000000238418579, CAST(N'2021-01-17' AS Date), N'Cake', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'22', N'ConoRoon Cake', N'image/COCONUT-MACAROON.png', N'Cononut and Macaroon Cake', 0.89999997615814209, CAST(N'2021-01-17' AS Date), N'Cake', 1, 30)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'23', N'Coke Light', N'image/coke-light.png', N'Coke Light', 0.5, CAST(N'2021-01-17' AS Date), N'Soda', 1, 499)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'24', N'Macaroon Cake', N'image/CSO_7425.png', N'Macaroon Cake', 0.5, CAST(N'2021-01-17' AS Date), N'Cake', 1, 198)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'25', N'Danasi Water', N'image/dasani_water.png', N'Danasi Water', 0.5, CAST(N'2021-01-17' AS Date), N'Water', 1, 489)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'26', N'Fish Burger', N'image/fish_burger.png', N'Fish Burger', 2, CAST(N'2021-01-17' AS Date), N'Burger', 1, 49)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'27', N'Capuchino', N'image/flatwhite.png', N'Capuchino', 3.5, CAST(N'2021-01-17' AS Date), N'Coffee', 1, 30)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'28', N'Matcha Ice Blended', N'image/frappematcha.png', N'Matcha Ice Blended', 3.2000000476837158, CAST(N'2021-01-17' AS Date), N'Ice Blended', 1, 45)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'29', N'Greentea Cake', N'image/GREENTEA-MUFFIN.png', N'Greentea Cake', 1.2000000476837158, CAST(N'2021-01-18' AS Date), N'Cake', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'3', N'Cheese Cake', N'image/BAKED-CHEESECAKE.png', N'Cake with Cheese', 2.0999999046325684, CAST(N'2000-01-08' AS Date), N'Cake', 1, 6)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'30', N'Pork Rice', N'image/grilled_pork_rice.png', N'Pork Rice', 3, CAST(N'2021-01-18' AS Date), N'Rice', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'31', N'Pork Egg Rice', N'image/grilled_porkegg_rice.png', N'Pork Egg Rice', 3.0999999046325684, CAST(N'2021-01-18' AS Date), N'Rice', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'32', N'Fanta', N'image/hero-pdt-Fanta-201703_0.png', N'Fanta', 2, CAST(N'2021-01-18' AS Date), N'Soda', 1, 100)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'33', N'Honey Cheese Cake', N'image/HOKEY-POKEY-CHEESECAKE.png', N'Honey Cheese Cake', 2.5, CAST(N'2021-01-18' AS Date), N'Cake', 1, 55)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'34', N'Choco Coffee', N'image/hotchoco.png', N'Choco Coffee', 3.7999999523162842, CAST(N'2021-01-18' AS Date), N'Coffee', 1, 49)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'35', N'Ice-Cream', N'image/hotfudge_mcsundae.png', N'Ice-Cream', 1, CAST(N'2021-01-18' AS Date), N'Ice-Cream', 1, 498)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'36', N'Hot Latte', N'image/hotlatte.png', N'Hot Latte', 2, CAST(N'2021-01-18' AS Date), N'Coffee', 0, 16)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'37', N'Hot Matcha', N'image/hotmatcha.png', N'Hot Matcha', 2, CAST(N'2021-01-18' AS Date), N'Coffee', 1, 49)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'38', N'Ice Americano', N'image/icedamericano.png', N'Ice Americano', 2, CAST(N'2021-01-18' AS Date), N'Coffee', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'39', N'Ice Latte', N'image/icedlatte.png', N'Ice Latte', 2, CAST(N'2021-01-18' AS Date), N'Coffee', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'4', N'Ice Milk Coffee', N'image/iced_milkVNcoffee.png', N'Cold Milk Coffee with ice ', 1.1000000238418579, CAST(N'2021-01-09' AS Date), N'Coffee', 1, 25)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'40', N'Kiwi Juice', N'image/kiwichiller.png', N'Kiwi Juice', 2, CAST(N'2021-01-18' AS Date), N'Juice', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'41', N'Ice-Cream Cone', N'image/mcdonalds_cone.png', N'Ice-Cream Cone', 0.5, CAST(N'2021-01-18' AS Date), N'Ice-Cream', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'42', N'Spicy Chicken Rice', N'image/mcspicy_chicken_rice.png', N'Spicy Chicken Rice', 4, CAST(N'2021-01-18' AS Date), N'Rice', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'43', N'Milo Milk', N'image/milo.png', N'Milo Milk', 0.5, CAST(N'2021-01-18' AS Date), N'Water', 1, 70)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'44', N'TH True Milk', N'image/th-true-milk-copy.png', N'TH True Milk', 0.5, CAST(N'2021-01-19' AS Date), N'Water', 0, 279)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'45', N'Strawberry Ice Cream', N'image/strawberry-mcsundae.png', N'Strawberry Ice Cream', 1.5, CAST(N'2021-01-19' AS Date), N'Ice-Cream', 0, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'46', N'Yogurt Cake', N'image/YOGURT-LEMON-CHEESECAKE.png', N'Yogurt Cake', 1.7999999523162842, CAST(N'2021-01-19' AS Date), N'Cake', 1, 50)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'5', N'Two chicken fried', N'image/2-ga-ran.png', N'Combo Two yummy chicken fried, coke and ....', 3.5, CAST(N'2021-01-11' AS Date), N'Chicken Fried', 0, 20)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'6', N'Three chicken fried', N'image/3-ga-ran.png', N'Three yummy chicken fried', 2.2999999523162842, CAST(N'2021-01-11' AS Date), N'Chicken Fried', 1, 19)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'7', N'Five chicken frieds', N'image/5-ga-ran.png', N'Five yummy chicken fried', 3.5, CAST(N'2021-01-11' AS Date), N'Chicken Fried', 1, 20)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'8', N'Six wing chicken frieds', N'image/6-wings.png', N'Six wing chicken fried', 5.0999999046325684, CAST(N'2021-01-11' AS Date), N'Chicken Fried', 1, 15)
INSERT [dbo].[Food] ([foodID], [foodname], [image], [description], [price], [createDate], [category], [status], [quantity]) VALUES (N'9', N'20 chicken wings fried', N'image/20pcs_chicken_mcwings.png', N'20 chicken wings fried', 15, CAST(N'2021-01-11' AS Date), N'Chicken Fried', 1, 5)
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'101351659515889630341', N'812AD378*&89q02@34h', N'benny20001456', N'cust', NULL, NULL, NULL)
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'107234487794169521418', N'812AD378*&89q02@34h', N'Nguyen Viet Bach', N'cust', N'FPT University', N'bachnvse140033@fpt.edu.vn', N'0123140033')
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'admin', N'admin', N'Admin', N'admin', NULL, NULL, NULL)
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'bachnv', N'123456', N'Nguyen Viet Bach', N'cust', N'Binh Thanh, HCM', N'ngvbach2000@gmail.com', N'0948494640')
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'cust', N'cust', N'Cust', N'cust', N'Test Customer', N'cust@hanashop.vn', N'0123456789')
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'NguyetIu', N'nguyetiu', N'Ngừi iu Bò', N'admin', N'Quáº­n 7', N'anhnguyet03032000.vn@gmail.com', N'0342949979')
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'ThiB', N'123', N'Tran Thi B', N'cust', NULL, NULL, NULL)
INSERT [dbo].[User] ([username], [password], [fullname], [role], [address], [email], [phone]) VALUES (N'VanA', N'123', N'Nguyen Van A', N'cust', NULL, NULL, NULL)
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090525', N'admin', N'DELETE food which foodID:  - 10', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090557', N'admin', N'DELETE food which foodID:  - 14 - 15 - 16 - 13 - 10', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090826', N'admin', N'UPDATE food which foodID: 13', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090846', N'admin', N'UPDATE food which foodID: 16', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090851', N'admin', N'UPDATE food which foodID: 15', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114090858', N'admin', N'UPDATE food which foodID: 14', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114091707', N'admin', N'UPDATE food which foodID: 16', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210114092806', N'admin', N'DELETE food which foodID:  - 5', CAST(N'2021-01-14' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210115141407', N'admin', N'DELETE food which foodID:  - 7', CAST(N'2021-01-15' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210115141415', N'admin', N'UPDATE food which foodID: 7', CAST(N'2021-01-15' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210115141428', N'admin', N'DELETE food which foodID:  - 11', CAST(N'2021-01-15' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210115141432', N'admin', N'UPDATE food which foodID: 11', CAST(N'2021-01-15' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210115141443', N'admin', N'UPDATE food which foodID: 11', CAST(N'2021-01-15' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210117093415', N'admin', N'UPDATE food which foodID: 22', CAST(N'2021-01-17' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091149', N'admin', N'DELETE food which foodID:  - 2 - 1', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091213', N'admin', N'UPDATE food which foodID: 2', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091246', N'admin', N'UPDATE food which foodID: 2', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091353', N'admin', N'DELETE food which foodID:  - 20', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091359', N'admin', N'UPDATE food which foodID: 20', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091413', N'admin', N'UPDATE food which foodID: 20', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091520', N'admin', N'UPDATE food which foodID: 18', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091533', N'admin', N'UPDATE food which foodID: 18', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091606', N'admin', N'UPDATE food which foodID: 5', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118091628', N'admin', N'UPDATE food which foodID: 1', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118123543', N'admin', N'UPDATE food which foodID: 29', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118123553', N'admin', N'UPDATE food which foodID: 29', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118124436', N'admin', N'UPDATE food which foodID: 36', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118125642', N'admin', N'UPDATE food which foodID: 35', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118131926', N'admin', N'DELETE food which foodID:  - 24 - 25 - 26', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118132028', N'admin', N'UPDATE food which foodID: 1', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118132525', N'admin', N'DELETE food which foodID:  - 30 - 31 - 32', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118132532', N'admin', N'UPDATE food which foodID: 33', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133747', N'admin', N'UPDATE food which foodID: 30', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133751', N'admin', N'UPDATE food which foodID: 31', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133754', N'admin', N'UPDATE food which foodID: 32', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133805', N'admin', N'UPDATE food which foodID: 24', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133808', N'admin', N'UPDATE food which foodID: 25', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118133812', N'admin', N'UPDATE food which foodID: 26', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118142620', N'admin', N'DELETE food which foodID:  - 30 - 31', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118142630', N'admin', N'UPDATE food which foodID: 30', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210118142634', N'admin', N'UPDATE food which foodID: 31', CAST(N'2021-01-18' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119140404', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119140408', N'admin', N'DELETE food which foodID:  - 44', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119140412', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119200635', N'admin', N'UPDATE food which foodID: 45', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119200943', N'admin', N'UPDATE food which foodID: 45', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119202823', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119203614', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119203642', N'admin', N'UPDATE food which foodID: 46', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213403', N'Nguyetiu', N'DELETE food which foodID:  - 36', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213446', N'Nguyetiu', N'UPDATE food which foodID: 39', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213554', N'Nguyetiu', N'UPDATE food which foodID: 22', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213641', N'Nguyetiu', N'UPDATE food which foodID: 11', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213711', N'Nguyetiu', N'UPDATE food which foodID: 7', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213744', N'Nguyetiu', N'UPDATE food which foodID: 5', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119213825', N'Nguyetiu', N'DELETE food which foodID:  - 2', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119214021', N'Nguyetiu', N'UPDATE food which foodID: 43', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119214034', N'Nguyetiu', N'UPDATE food which foodID: 43', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119214153', N'Nguyetiu', N'UPDATE food which foodID: 4', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210119214253', N'Nguyetiu', N'UPDATE food which foodID: 25', CAST(N'2021-01-19' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210120122201', N'admin', N'UPDATE food which foodID: 31', CAST(N'2021-01-20' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210120131519', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-20' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210120131803', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-20' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210120131809', N'admin', N'UPDATE food which foodID: 44', CAST(N'2021-01-20' AS Date))
INSERT [dbo].[UserHistory] ([HistoryID], [username], [content], [date]) VALUES (N'20210120132330', N'admin', N'DELETE food which foodID:  - 44 - 45', CAST(N'2021-01-20' AS Date))
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_User] FOREIGN KEY([username])
REFERENCES [dbo].[User] ([username])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_User]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Bill] FOREIGN KEY([billID])
REFERENCES [dbo].[Bill] ([billID])
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Bill]
GO
ALTER TABLE [dbo].[UserHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserHistory_User] FOREIGN KEY([username])
REFERENCES [dbo].[User] ([username])
GO
ALTER TABLE [dbo].[UserHistory] CHECK CONSTRAINT [FK_UserHistory_User]
GO
USE [master]
GO
ALTER DATABASE [HanaShop] SET  READ_WRITE 
GO

CREATE TABLE `AspNetUsers` (
	-- is UUID
    `Id`                   VARCHAR (36)     NOT NULL,
    `AccessFailedCount`    INT                NOT NULL,
	-- user.ConcurrencyStamp = Guid.NewGuid().ToString();
    `ConcurrencyStamp`     VARCHAR (36)     NULL,
    `Email`                VARCHAR (256)     NULL,
    `EmailConfirmed`       BIT                NOT NULL,
    `LockoutEnabled`       BIT                NOT NULL,
    `LockoutEnd`           TIMESTAMP NULL,
    `NormalizedEmail`      VARCHAR (256)     NULL,
    `NormalizedUserName`   VARCHAR (256)     NULL,
	-- hash will be 61 bytes or 84 base64 chars in length (PBKDF2 with HMAC-SHA256) 
	-- see https://github.com/aspnet/Identity/blob/feedcb5c53444f716ef5121d3add56e11c7b71e5/src/Core/PasswordHasher.cs#L146
    `PasswordHash`         VARCHAR (84)     NULL, 
    `PhoneNumber`          VARCHAR (32)     NULL,
    `PhoneNumberConfirmed` BIT                NOT NULL,
	-- 20 random bytes in Base32 encoding --> 32 chars
    `SecurityStamp`        VARCHAR (32)     NULL,
    `TwoFactorEnabled`     BIT                NOT NULL,
    `UserName`             VARCHAR (256)     NULL,
    CONSTRAINT `PK_AspNetUsers` PRIMARY KEY (`Id` ASC)
);

-- From Microsoft.AspNetCore.Identity source code:
-- columns: table => new
--	{
--		UserId = table.Column<string>(nullable: false),
--		LoginProvider = table.Column<string>(maxLength: 128, nullable: false),
--		Name = table.Column<string>(maxLength: 128, nullable: false),
--		Value = table.Column<string>(nullable: true)
CREATE TABLE `AspNetUserTokens` (
    `UserId`        VARCHAR (36) NOT NULL,
    `LoginProvider` VARCHAR (128) NOT NULL,
    `Name`          VARCHAR (128) NOT NULL,
    `Value`         VARCHAR (4096) NULL,
    CONSTRAINT `PK_AspNetUserTokens` PRIMARY KEY (`UserId` ASC, `LoginProvider` ASC, `Name` ASC)
);

CREATE TABLE `AspNetRoles` (
	-- public IdentityRole()
    -- {
    --     Id = Guid.NewGuid().ToString();
    -- }
    `Id`               VARCHAR (36) NOT NULL,
	-- role.ConcurrencyStamp = Guid.NewGuid().ToString();
    `ConcurrencyStamp` VARCHAR (36) NULL,
    `Name`             VARCHAR (256) NULL,
    `NormalizedName`   VARCHAR (256) NULL,
    CONSTRAINT `PK_AspNetRoles` PRIMARY KEY (`Id` ASC)
);

CREATE TABLE `AspNetUserRoles` (
    `UserId` VARCHAR (36) NOT NULL,
    `RoleId` VARCHAR (36) NOT NULL,
    CONSTRAINT `PK_AspNetUserRoles` PRIMARY KEY (`UserId` ASC, `RoleId` ASC),
    CONSTRAINT FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

-- name: "AspNetUserLogins",
-- columns: table => new
-- {
-- 		LoginProvider = table.Column<string>(maxLength: 128, nullable: false),
-- 		ProviderKey = table.Column<string>(maxLength: 128, nullable: false),
-- 		ProviderDisplayName = table.Column<string>(nullable: true),
-- 		UserId = table.Column<string>(nullable: false)
-- },
CREATE TABLE `AspNetUserLogins` (
    `LoginProvider`       VARCHAR (128) NOT NULL,
	-- Assert.True(DbUtil.VerifyMaxLength(db, "AspNetUserLogins", 128, "LoginProvider", "ProviderKey"));
    `ProviderKey`         VARCHAR (128) NOT NULL,
    `ProviderDisplayName` VARCHAR (4096) NULL,
    `UserId`              VARCHAR (36) NOT NULL,
    CONSTRAINT `PK_AspNetUserLogins` PRIMARY KEY (`LoginProvider` ASC, `ProviderKey` ASC),
    CONSTRAINT FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetUserClaims` (
    `Id`         INT            AUTO_INCREMENT NOT NULL,
    `ClaimType`  VARCHAR (4096) NULL,
    `ClaimValue` VARCHAR (4096) NULL,
    `UserId`     VARCHAR (36) NOT NULL,
    CONSTRAINT `PK_AspNetUserClaims` PRIMARY KEY (`Id` ASC),
    CONSTRAINT FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
);

CREATE TABLE `AspNetRoleClaims` (
    `Id`         INT            AUTO_INCREMENT NOT NULL,
    `ClaimType`  VARCHAR (4096) NULL,
    `ClaimValue` VARCHAR (4096) NULL,
    `RoleId`     VARCHAR (36) NOT NULL,
    CONSTRAINT `PK_AspNetRoleClaims` PRIMARY KEY (`Id` ASC),
    CONSTRAINT FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
);

CREATE INDEX `EmailIndex`
    ON `AspNetUsers`(`NormalizedEmail` ASC);

CREATE UNIQUE INDEX `UserNameIndex`
    ON `AspNetUsers`(`NormalizedUserName` ASC);

CREATE INDEX `RoleNameIndex`
    ON `AspNetRoles`(`NormalizedName` ASC);
	
CREATE INDEX `IX_AspNetUserRoles_RoleId`
    ON `AspNetUserRoles`(`RoleId` ASC);
	
CREATE INDEX `IX_AspNetUserRoles_UserId`
    ON `AspNetUserRoles`(`UserId` ASC);

CREATE INDEX `IX_AspNetUserLogins_UserId`
    ON `AspNetUserLogins`(`UserId` ASC);
	
CREATE INDEX `IX_AspNetUserClaims_UserId`
    ON `AspNetUserClaims`(`UserId` ASC);

CREATE INDEX `IX_AspNetRoleClaims_RoleId`
    ON `AspNetRoleClaims`(`RoleId` ASC);

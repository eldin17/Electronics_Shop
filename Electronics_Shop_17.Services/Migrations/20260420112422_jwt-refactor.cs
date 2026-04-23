using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Electronics_Shop_17.Services.Migrations
{
    /// <inheritdoc />
    public partial class jwtrefactor : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "RefreshTokenExpiry",
                table: "UserAccounts",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<byte[]>(
                name: "RefreshTokenHash",
                table: "UserAccounts",
                type: "varbinary(max)",
                nullable: true);

            migrationBuilder.AddColumn<byte[]>(
                name: "RefreshTokenSalt",
                table: "UserAccounts",
                type: "varbinary(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RefreshTokenExpiry",
                table: "UserAccounts");

            migrationBuilder.DropColumn(
                name: "RefreshTokenHash",
                table: "UserAccounts");

            migrationBuilder.DropColumn(
                name: "RefreshTokenSalt",
                table: "UserAccounts");
        }
    }
}

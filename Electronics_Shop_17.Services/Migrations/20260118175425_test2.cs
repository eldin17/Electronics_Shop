using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Electronics_Shop_17.Services.Migrations
{
    /// <inheritdoc />
    public partial class test2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // 1️⃣ Drop FK and index on CustomerId first
            migrationBuilder.DropForeignKey(
                name: "FK_PaymentMethods_Customers_CustomerId",
                table: "PaymentMethods");

            migrationBuilder.DropIndex(
                name: "IX_PaymentMethods_CustomerId",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Type",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Provider",
                table: "PaymentMethods");

            // 2️⃣ Drop old columns
            migrationBuilder.DropColumn(
                name: "CustomerId",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "ExpiryDate",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "IsDefault",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Key",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "isDeleted",
                table: "PaymentMethods");

            // 3️⃣ Add new columns
            migrationBuilder.AddColumn<string>(
                name: "Code",
                table: "PaymentMethods",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Type",
                table: "PaymentMethods",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Provider",
                table: "PaymentMethods",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // 1️⃣ Drop newly added columns
            migrationBuilder.DropColumn(
                name: "Code",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Type",
                table: "PaymentMethods");

            migrationBuilder.DropColumn(
                name: "Provider",
                table: "PaymentMethods");

            // 2️⃣ Recreate old columns
            migrationBuilder.AddColumn<int>(
                name: "CustomerId",
                table: "PaymentMethods",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "ExpiryDate",
                table: "PaymentMethods",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1));

            migrationBuilder.AddColumn<bool>(
                name: "IsDefault",
                table: "PaymentMethods",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Key",
                table: "PaymentMethods",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "isDeleted",
                table: "PaymentMethods",
                type: "bit",
                nullable: false,
                defaultValue: false);

            // 3️⃣ Recreate index and FK
            migrationBuilder.CreateIndex(
                name: "IX_PaymentMethods_CustomerId",
                table: "PaymentMethods",
                column: "CustomerId");

            migrationBuilder.AddForeignKey(
                name: "FK_PaymentMethods_Customers_CustomerId",
                table: "PaymentMethods",
                column: "CustomerId",
                principalTable: "Customers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
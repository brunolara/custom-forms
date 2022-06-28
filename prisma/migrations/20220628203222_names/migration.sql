/*
  Warnings:

  - You are about to drop the `field` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `fieldtype` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `formconfig` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `formentry` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `formentryvalue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `field` DROP FOREIGN KEY `Field_field_type_id_fkey`;

-- DropForeignKey
ALTER TABLE `field` DROP FOREIGN KEY `Field_form_config_id_fkey`;

-- DropForeignKey
ALTER TABLE `formconfig` DROP FOREIGN KEY `FormConfig_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `formentry` DROP FOREIGN KEY `FormEntry_form_config_id_fkey`;

-- DropForeignKey
ALTER TABLE `formentryvalue` DROP FOREIGN KEY `FormEntryValue_fieldId_fkey`;

-- DropForeignKey
ALTER TABLE `formentryvalue` DROP FOREIGN KEY `FormEntryValue_formEntryId_fkey`;

-- DropTable
DROP TABLE `field`;

-- DropTable
DROP TABLE `fieldtype`;

-- DropTable
DROP TABLE `formconfig`;

-- DropTable
DROP TABLE `formentry`;

-- DropTable
DROP TABLE `formentryvalue`;

-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_configs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `field_types` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `visibility` BOOLEAN NOT NULL DEFAULT true,
    `errorMsg` VARCHAR(191) NULL,
    `html_tag` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fields` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `name` VARCHAR(191) NOT NULL,
    `label` VARCHAR(191) NOT NULL,
    `max_length` INTEGER NULL,
    `min_length` INTEGER NULL,
    `required` BOOLEAN NOT NULL DEFAULT false,
    `additional_data` JSON NULL,
    `order` INTEGER NULL,
    `placeholder` VARCHAR(191) NULL,
    `hint` VARCHAR(191) NULL,
    `field_type_id` INTEGER NOT NULL,
    `form_config_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_entries` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `form_config_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_entry_values` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `value` VARCHAR(191) NOT NULL,
    `formEntryId` INTEGER NOT NULL,
    `fieldId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `form_configs` ADD CONSTRAINT `form_configs_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `fields` ADD CONSTRAINT `fields_form_config_id_fkey` FOREIGN KEY (`form_config_id`) REFERENCES `form_configs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `fields` ADD CONSTRAINT `fields_field_type_id_fkey` FOREIGN KEY (`field_type_id`) REFERENCES `field_types`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `form_entries` ADD CONSTRAINT `form_entries_form_config_id_fkey` FOREIGN KEY (`form_config_id`) REFERENCES `form_configs`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `form_entry_values` ADD CONSTRAINT `form_entry_values_fieldId_fkey` FOREIGN KEY (`fieldId`) REFERENCES `fields`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `form_entry_values` ADD CONSTRAINT `form_entry_values_formEntryId_fkey` FOREIGN KEY (`formEntryId`) REFERENCES `form_entries`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

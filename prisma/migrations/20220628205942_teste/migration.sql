/*
  Warnings:

  - Added the required column `title` to the `form_configs` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `form_configs` ADD COLUMN `title` VARCHAR(191) NOT NULL;

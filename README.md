# Document Capture Training objects
This repository contains an application that is used to prepare a Microsoft Business Central 18 Database for a partner training.

The extension can be run via Action "Prepare DC Training" from the **Order Processor** Role Center.
It will run the following procedures:
  1. Delete all existing purchase invoices
  2. Reopens existing purchase orders
  3. Delete sales invoices
  4. Repoens Sales Orders and assigns them Salesperson/Purchaser code RL or TZ (depending of database localization)
  5. Creates Purchase Order 1003 with lines for order matching

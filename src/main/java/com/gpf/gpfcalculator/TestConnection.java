package com.gpf.gpfcalculator;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestConnection {

    public static void main(String[] args) {

        String url = "jdbc:sqlserver://localhost:1433;databaseName=GPFDB;encrypt=true;trustServerCertificate=true";

        String username = "sa";
        String password = "Akash@12345";

        try {
            Connection con = DriverManager.getConnection(url, username, password);
            System.out.println("Connected Successfully!");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
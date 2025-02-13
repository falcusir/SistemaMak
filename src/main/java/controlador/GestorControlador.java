/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import modelo.GestorModelo;



/**
 *
 * @author Usuario
 */
public class GestorControlador {

    //INSTANCIO UN OBJETO DEL MODELO A INSERTAR
    private GestorModelo gm;
    //INSTANCIAR LA CONEXIÓN A LA BASE DE DATOS
    ConexionProyectoBDD conectar = new ConexionProyectoBDD();
    //CLASE QUE ME PERMITA CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection) conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL
    PreparedStatement ejecutar;
    //OBTENER RESULTADOS DE LA CONSULTA
    ResultSet resultado;

    //MÉTODOS DE TRANSACCIONABILIDAD
    public void insertarGestor(GestorModelo gm) {
        //1.- UTILIZAR EXCEPCIÓN
        try {//LANZAR TESTEAR UN CONJUNTO DE CÓDIGO 
            String sentenciaSQL = "call insertar_empleador('"+gm.getNombre()+"','"+gm.getApellido()+"','"+gm.getCedula()+"','"+gm.getFechaNac()+"','"+gm.getCorreo()+"','"+gm.getFechaAsignacion()+"');";
            ejecutar = conectado.prepareCall(sentenciaSQL);
            //TODA INSERCIÓN DEVUELVE UN ESTADO >0 CUANDO FUE FAVORABLE Y MENOR A O CUANDO NO SE REALIZÓ 
            int res = ejecutar.executeUpdate();
            if (res > 0) {
                JOptionPane.showMessageDialog(null,"Gestor de Proyecto Creado con éxito");
                ejecutar.close();
            }else{
                JOptionPane.showMessageDialog(null,"El Gestor de Proyecto no ha sido creado,"
                        + " revise que los datos ingresados sean correctos");
            }

        } catch (SQLException e) {
            //CAPTURAR PARA DARLE UN TRATAMIENTO 
            JOptionPane.showMessageDialog(null,"Comuniquese con el Administrador para solicitar ayuda");
                
        }

    }
    
    public ArrayList<Object[]> buscarGestor(String p_cedula) {
            ArrayList<Object[]> listaObject=new ArrayList<>();
        try {
            String sql = "call sp_BuscarEmpleador('%"+p_cedula+"%');";
            ejecutar = (PreparedStatement) conectado.prepareCall(sql);
            resultado = ejecutar.executeQuery();
            int cont = 1;
            while (resultado.next()) {
                Object[] obgestor = new Object[9];
                for (int i = 0; i <8; i++) {
                    obgestor[i+1] = resultado.getObject(i+1);
                }
                obgestor[0]=cont;
                listaObject.add(obgestor);
                cont++;
            }
            ejecutar.close();
            return listaObject;
           
        } catch (SQLException e) {
            System.out.println("ERROR SQL"+e);
        }
        return null;
    }
    
    public ArrayList<Object[]> datosGestores() {
        ArrayList<Object[]> listaObject=new ArrayList<>();
        
        try {
            String sql = "call sp_ListarEmpleador();";
            ejecutar = (PreparedStatement) conectado.prepareCall(sql);
            resultado = ejecutar.executeQuery();
            int cont = 1;
            while (resultado.next()) {
                Object[] obgestor = new Object[9];
                for (int i = 0; i < 8; i++) {
                    obgestor[i+1] = resultado.getObject(i+1);
                }
                obgestor[0]=cont;
                listaObject.add(obgestor);
                cont++;
            }
            ejecutar.close();
            return listaObject;

        } catch (SQLException e) {
            System.out.println("ERROR SQL CARGA GESTORES");

        }

        return null;
    }
    
    public void actualizarGestor(GestorModelo gm) {
        try {
            String sentenciaSQL = "call sp_actualizarEmpleador('"+gm.getCedula()+"','"+ gm.getNombre()+"','"+gm.getApellido()+"','"+gm.getFechaNac()+"','"+gm.getCorreo()+"','"+gm.getFechaAsignacion()+"');";
            ejecutar = (PreparedStatement) conectado.prepareCall(sentenciaSQL);
            int res = ejecutar.executeUpdate();
            if (res > 0) {
                JOptionPane.showMessageDialog(null, "Gestor de Proyecto Actualizado con Éxito");
            
                ejecutar.close();
            } else {
                JOptionPane.showMessageDialog(null, "Revise los datos ingresados");
              
            }
        } catch (SQLException e) {
            System.out.println("ERROR SQL");
        }
    }

}

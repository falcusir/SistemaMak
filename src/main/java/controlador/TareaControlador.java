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
import modelo.TareaModelo;


/**
 *
 * @author Usuario
 */
public class TareaControlador {

    //INSTANCIO UN OBJETO DEL MODELO A INSERTAR
    private TareaModelo tm;
    //INSTANCIAR LA CONEXIÓN A LA BASE DE DATOS
    ConexionProyectoBDD conectar = new ConexionProyectoBDD();
    //CLASE QUE ME PERMITA CONECTARME DIRECTAMENTE A MYSQL
    Connection conectado = (Connection) conectar.conectar();
    //CLASE QUE ME PERMITE EJECUTAR MI SENTENCIA SQL
    PreparedStatement ejecutar;
    //OBTENER RESULTADOS DE LA CONSULTA
    ResultSet resultado;

    //MÉTODOS DE TRANSACCIONABILIDAD
    public void insertarTarea(TareaModelo tm) {
        //1.- UTILIZAR EXCEPCIÓN
        try {//LANZAR TESTEAR UN CONJUNTO DE CÓDIGO 
            String sentenciaSQL = "call insertar_empleador('"+tm.getNombreTarea()+"','"+tm.getDescripcionTarea()+"','"+tm.getPrioridad()+"','"+tm.getFechaInicioTarea()+"','"+tm.getFechaFinTarea()+"','"+tm.getEstadoTarea()+"');";
            ejecutar = conectado.prepareCall(sentenciaSQL);
            //TODA INSERCIÓN DEVUELVE UN ESTADO >0 CUANDO FUE FAVORABLE Y MENOR A O CUANDO NO SE REALIZÓ 
            int res = ejecutar.executeUpdate();
            if (res > 0) {
                JOptionPane.showMessageDialog(null,"Tarea creada con éxito");
                ejecutar.close();
            }else{
                JOptionPane.showMessageDialog(null,"La Tarea no ha sido creada,"
                        + " revise que los datos ingresados sean correctos");
            }

        } catch (SQLException e) {
            //CAPTURAR PARA DARLE UN TRATAMIENTO 
            JOptionPane.showMessageDialog(null,"Comuniquese con el Administrador para solicitar ayuda");
                
        }

    }
    
    public ArrayList<Object[]> buscarTarea(String p_cedula) {
            ArrayList<Object[]> listaObject=new ArrayList<>();
        try {
            String sql = "call sp_BuscarEmpleador('%"+p_cedula+"%');";
            ejecutar = (PreparedStatement) conectado.prepareCall(sql);
            resultado = ejecutar.executeQuery();
            int cont = 1;
            while (resultado.next()) {
                Object[] obtarea = new Object[9];
                for (int i = 0; i <8; i++) {
                    obtarea[i+1] = resultado.getObject(i+1);
                }
                obtarea[0]=cont;
                listaObject.add(obtarea);
                cont++;
            }
            ejecutar.close();
            return listaObject;
           
        } catch (SQLException e) {
            System.out.println("ERROR SQL"+e);
        }
        return null;
    }
    
    public ArrayList<Object[]> datosTareas() {
        ArrayList<Object[]> listaObject=new ArrayList<>();
        
        try {
            String sql = "call sp_ListarEmpleador();";
            ejecutar = (PreparedStatement) conectado.prepareCall(sql);
            resultado = ejecutar.executeQuery();
            int cont = 1;
            while (resultado.next()) {
                Object[] obtarea = new Object[9];
                for (int i = 0; i < 8; i++) {
                    obtarea[i+1] = resultado.getObject(i+1);
                }
                obtarea[0]=cont;
                listaObject.add(obtarea);
                cont++;
            }
            ejecutar.close();
            return listaObject;

        } catch (SQLException e) {
            System.out.println("ERROR SQL CARGA TAREAS");

        }

        return null;
    }
    
    public void actualizarTarea(TareaModelo tm) {
        try {
            String sentenciaSQL = "call sp_actualizarEmpleador('"+tm.getNombreTarea()+"','"+tm.getDescripcionTarea()+"','"+tm.getPrioridad()+"','"+tm.getFechaInicioTarea()+"','"+tm.getFechaFinTarea()+"','"+tm.getEstadoTarea()+"');";
            ejecutar = (PreparedStatement) conectado.prepareCall(sentenciaSQL);
            int res = ejecutar.executeUpdate();
            if (res > 0) {
                JOptionPane.showMessageDialog(null, "Tarea Actualizada con Éxito");
            
                ejecutar.close();
            } else {
                JOptionPane.showMessageDialog(null, "Revise los datos ingresados");
              
            }
        } catch (SQLException e) {
            System.out.println("ERROR SQL");
        }
    }

}

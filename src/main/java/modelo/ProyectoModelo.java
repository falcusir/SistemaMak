/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class ProyectoModelo {
    private int idProyecto;
    private GestorModelo idGestor;
    private String nombreProy;
    private String descripcionProy;
    private String fechaInicio;
    private String fechaFin;

    public ProyectoModelo() {
    }

    public ProyectoModelo(int idProyecto, GestorModelo idGestor, String nombreProy, String descripcionProy, String fechaInicio, String fechaFin) {
        this.idProyecto = idProyecto;
        this.idGestor = idGestor;
        this.nombreProy = nombreProy;
        this.descripcionProy = descripcionProy;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public GestorModelo getIdGestor() {
        return idGestor;
    }

    public void setIdGestor(GestorModelo idGestor) {
        this.idGestor = idGestor;
    }

    public String getNombreProy() {
        return nombreProy;
    }

    public void setNombreProy(String nombreProy) {
        this.nombreProy = nombreProy;
    }

    public String getDescripcionProy() {
        return descripcionProy;
    }

    public void setDescripcionProy(String descripcionProy) {
        this.descripcionProy = descripcionProy;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    @Override
    public String toString() {
         return "DATOS DEL PROYECTO\n"+
                "Nombre del Proyecto: "+getNombreProy()+"\n"+
                "Desccripción del Proyecto:: "+getDescripcionProy()+"\n"+
                "Fecha de Inicio: "+getFechaInicio()+"\n"+
                "Fecha de Entrega: "+getFechaFin()+"\n";
    }
    
    
}

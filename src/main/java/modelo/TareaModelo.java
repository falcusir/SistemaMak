/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class TareaModelo {

    private int idTarea;
    private ProyectoModelo idProyecto;
    private MiembroEModelo idMiembroEq;
    private String nombreTarea;
    private String descripcionTarea;
    private String prioridad;
    private String FechaInicioTarea;
    private String FechaFinTarea;
    private String estadoTarea;

    public TareaModelo() {
    }

    public TareaModelo(int idTarea, ProyectoModelo idProyecto, MiembroEModelo idMiembroEq, String nombreTarea, String descripcionTarea, String prioridad, String FechaInicioTarea, String FechaFinTarea, String estadoTarea) {
        this.idTarea = idTarea;
        this.idProyecto = idProyecto;
        this.idMiembroEq = idMiembroEq;
        this.nombreTarea = nombreTarea;
        this.descripcionTarea = descripcionTarea;
        this.prioridad = prioridad;
        this.FechaInicioTarea = FechaInicioTarea;
        this.FechaFinTarea = FechaFinTarea;
        this.estadoTarea = estadoTarea;
    }

    public int getIdTarea() {
        return idTarea;
    }

    public void setIdTarea(int idTarea) {
        this.idTarea = idTarea;
    }

    public ProyectoModelo getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(ProyectoModelo idProyecto) {
        this.idProyecto = idProyecto;
    }

    public MiembroEModelo getIdMiembroEq() {
        return idMiembroEq;
    }

    public void setIdMiembroEq(MiembroEModelo idMiembroEq) {
        this.idMiembroEq = idMiembroEq;
    }

    public String getNombreTarea() {
        return nombreTarea;
    }

    public void setNombreTarea(String nombreTarea) {
        this.nombreTarea = nombreTarea;
    }

    public String getDescripcionTarea() {
        return descripcionTarea;
    }

    public void setDescripcionTarea(String descripcionTarea) {
        this.descripcionTarea = descripcionTarea;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getFechaInicioTarea() {
        return FechaInicioTarea;
    }

    public void setFechaInicioTarea(String FechaInicioTarea) {
        this.FechaInicioTarea = FechaInicioTarea;
    }

    public String getFechaFinTarea() {
        return FechaFinTarea;
    }

    public void setFechaFinTarea(String FechaFinTarea) {
        this.FechaFinTarea = FechaFinTarea;
    }

    public String getEstadoTarea() {
        return estadoTarea;
    }

    public void setEstadoTarea(String estadoTarea) {
        this.estadoTarea = estadoTarea;
    }

    @Override
    public String toString() {
        return "DATOS DE LA TAREA\n"
                + "Nombre: " + getNombreTarea() + "\n"
                + "Descripción: " + getDescripcionTarea() + "\n"
                + "Prioridad: " + getPrioridad() + "\n"
                + "Fecha de Inicio: " + getFechaInicioTarea() + "\n"
                + "Fecha Fin: " + getFechaFinTarea() + "\n"
                + "Estado: " + getEstadoTarea();
    }
}

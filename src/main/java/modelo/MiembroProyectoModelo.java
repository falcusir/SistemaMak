/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author Dell Core i7
 */
public class MiembroProyectoModelo {
    private int idMiembroProy;
    private MiembroEModelo idMiembroEq;
    private ProyectoModelo idProyeto;
    private String fechaAsigProy;
    private String nombreEquipo;

    public MiembroProyectoModelo() {
    }

    public MiembroProyectoModelo(int idMiembroProy, MiembroEModelo idMiembroEq, ProyectoModelo idProyeto, String fechaAsigProy, String nombreEquipo) {
        this.idMiembroProy = idMiembroProy;
        this.idMiembroEq = idMiembroEq;
        this.idProyeto = idProyeto;
        this.fechaAsigProy = fechaAsigProy;
        this.nombreEquipo = nombreEquipo;
    }

    public int getIdMiembroProy() {
        return idMiembroProy;
    }

    public void setIdMiembroProy(int idMiembroProy) {
        this.idMiembroProy = idMiembroProy;
    }

    public MiembroEModelo getIdMiembroEq() {
        return idMiembroEq;
    }

    public void setIdMiembroEq(MiembroEModelo idMiembroEq) {
        this.idMiembroEq = idMiembroEq;
    }

    public ProyectoModelo getIdProyeto() {
        return idProyeto;
    }

    public void setIdProyeto(ProyectoModelo idProyeto) {
        this.idProyeto = idProyeto;
    }

    public String getFechaAsigProy() {
        return fechaAsigProy;
    }

    public void setFechaAsigProy(String fechaAsigProy) {
        this.fechaAsigProy = fechaAsigProy;
    }

    public String getNombreEquipo() {
        return nombreEquipo;
    }

    public void setNombreEquipo(String nombreEquipo) {
        this.nombreEquipo = nombreEquipo;
    }
    
    
    
}

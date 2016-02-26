/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Hamal
 */
public class Compra {
    private long idCompra;
    private double precioTotalCompraCalculado;
    private double precioTotalCompra;
    private Date fechaCompra;
    private Date fechaEntregaCompra;
    private String fechaEntregaCompraS;
    private Time horaEntregaCompra;
    private String horaEntregaCompraS;
    private Date fechaUPagoCompra;
    private String fechaUPagoCompraS;
    private Time horaUPagoCompra;
    private String horaUPagoCompraS;
    private Date fechaVencimientoCompra;
    private String fechaVencimientoCompraS;
    private String estadoCompra;
    private String nroRemitoCompra;
    private String nroFacturaCompra;
    private long cuitProveedor;
    private long dniUsuario;
    private ArrayList<Entidades.LineaDeCompra> lineasCompra;
    private String proveedor;
    private String idCompraS;

    /**
     * @return the idCompra
     */
    public long getIdCompra() {
        return idCompra;
    }

    /**
     * @param idCompra the idCompra to set
     */
    public void setIdCompra(long idCompra) {
        this.idCompra = idCompra;
    }

    /**
     * @return the precioTotalCompraCalculado
     */
    public double getPrecioTotalCompraCalculado() {
        return precioTotalCompraCalculado;
    }

    /**
     * @param precioTotalCompraCalculado the precioTotalCompraCalculado to set
     */
    public void setPrecioTotalCompraCalculado(double precioTotalCompraCalculado) {
        this.precioTotalCompraCalculado = precioTotalCompraCalculado;
    }

    /**
     * @return the precioTotalCompra
     */
    public double getPrecioTotalCompra() {
        return precioTotalCompra;
    }

    /**
     * @param precioTotalCompra the precioTotalCompra to set
     */
    public void setPrecioTotalCompra(double precioTotalCompra) {
        this.precioTotalCompra = precioTotalCompra;
    }

    /**
     * @return the fechaCompra
     */
    public Date getFechaCompra() {
        return fechaCompra;
    }

    /**
     * @param fechaCompra the fechaCompra to set
     */
    public void setFechaCompra(Date fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    /**
     * @return the fechaEntregaCompra
     */
    public Date getFechaEntregaCompra() {
        return fechaEntregaCompra;
    }

    /**
     * @param fechaEntregaCompra the fechaEntregaCompra to set
     */
    public void setFechaEntregaCompra(Date fechaEntregaCompra) {
        this.fechaEntregaCompra = fechaEntregaCompra;
    }

    /**
     * @return the horaEntregaCompra
     */
    public Time getHoraEntregaCompra() {
        return horaEntregaCompra;
    }

    /**
     * @param horaEntregaCompra the horaEntregaCompra to set
     */
    public void setHoraEntregaCompra(Time horaEntregaCompra) {
        this.horaEntregaCompra = horaEntregaCompra;
    }

    /**
     * @return the fechaUPagoCompra
     */
    public Date getFechaUPagoCompra() {
        return fechaUPagoCompra;
    }

    /**
     * @param fechaUPagoCompra the fechaUPagoCompra to set
     */
    public void setFechaUPagoCompra(Date fechaUPagoCompra) {
        this.fechaUPagoCompra = fechaUPagoCompra;
    }

    /**
     * @return the horaUPagoCompra
     */
    public Time getHoraUPagoCompra() {
        return horaUPagoCompra;
    }

    /**
     * @param horaUPagoCompra the horaUPagoCompra to set
     */
    public void setHoraUPagoCompra(Time horaUPagoCompra) {
        this.horaUPagoCompra = horaUPagoCompra;
    }

    /**
     * @return the fechaVencimientoCompra
     */
    public Date getFechaVencimientoCompra() {
        return fechaVencimientoCompra;
    }

    /**
     * @param fechaVencimientoCompra the fechaVencimientoCompra to set
     */
    public void setFechaVencimientoCompra(Date fechaVencimientoCompra) {
        this.fechaVencimientoCompra = fechaVencimientoCompra;
    }

    /**
     * @return the estadoCompra
     */
    public String getEstadoCompra() {
        return estadoCompra;
    }

    /**
     * @param estadoCompra the estadoCompra to set
     */
    public void setEstadoCompra(String estadoCompra) {
        this.estadoCompra = estadoCompra;
    }

    /**
     * @return the nroRemitoCompra
     */
    public String getNroRemitoCompra() {
        return nroRemitoCompra;
    }

    /**
     * @param nroRemitoCompra the nroRemitoCompra to set
     */
    public void setNroRemitoCompra(String nroRemitoCompra) {
        this.nroRemitoCompra = nroRemitoCompra;
    }

    /**
     * @return the nroFacturaCompra
     */
    public String getNroFacturaCompra() {
        return nroFacturaCompra;
    }

    /**
     * @param nroFacturaCompra the nroFacturaCompra to set
     */
    public void setNroFacturaCompra(String nroFacturaCompra) {
        this.nroFacturaCompra = nroFacturaCompra;
    }

    /**
     * @return the cuitProveedor
     */
    public long getCuitProveedor() {
        return cuitProveedor;
    }

    /**
     * @param cuitProveedor the cuitProveedor to set
     */
    public void setCuitProveedor(long cuitProveedor) {
        this.cuitProveedor = cuitProveedor;
    }

    /**
     * @return the dniUsuario
     */
    public long getDniUsuario() {
        return dniUsuario;
    }

    /**
     * @param dniUsuario the dniUsuario to set
     */
    public void setDniUsuario(long dniUsuario) {
        this.dniUsuario = dniUsuario;
    }

    /**
     * @return the lineasCompra
     */
    public ArrayList<Entidades.LineaDeCompra> getLineasCompra() {
        return lineasCompra;
    }

    /**
     * @param lineasCompra the lineasCompra to set
     */
    public void setLineasCompra(ArrayList<Entidades.LineaDeCompra> lineasCompra) {
        this.lineasCompra = lineasCompra;
    }

    /**
     * @return the fechaEntregaCompraS
     */
    public String getFechaEntregaCompraS() {
        return fechaEntregaCompraS;
    }

    /**
     * @param fechaEntregaCompraS the fechaEntregaCompraS to set
     */
    public void setFechaEntregaCompraS(String fechaEntregaCompraS) {
        this.fechaEntregaCompraS = fechaEntregaCompraS;
    }

    /**
     * @return the horaEntregaCompraS
     */
    public String getHoraEntregaCompraS() {
        return horaEntregaCompraS;
    }

    /**
     * @param horaEntregaCompraS the horaEntregaCompraS to set
     */
    public void setHoraEntregaCompraS(String horaEntregaCompraS) {
        this.horaEntregaCompraS = horaEntregaCompraS;
    }

    /**
     * @return the fechaUPagoCompraS
     */
    public String getFechaUPagoCompraS() {
        return fechaUPagoCompraS;
    }

    /**
     * @param fechaUPagoCompraS the fechaUPagoCompraS to set
     */
    public void setFechaUPagoCompraS(String fechaUPagoCompraS) {
        this.fechaUPagoCompraS = fechaUPagoCompraS;
    }

    /**
     * @return the horaUPagoCompraS
     */
    public String getHoraUPagoCompraS() {
        return horaUPagoCompraS;
    }

    /**
     * @param horaUPagoCompraS the horaUPagoCompraS to set
     */
    public void setHoraUPagoCompraS(String horaUPagoCompraS) {
        this.horaUPagoCompraS = horaUPagoCompraS;
    }

    /**
     * @return the fechaVencimientoCompraS
     */
    public String getFechaVencimientoCompraS() {
        return fechaVencimientoCompraS;
    }

    /**
     * @param fechaVencimientoCompraS the fechaVencimientoCompraS to set
     */
    public void setFechaVencimientoCompraS(String fechaVencimientoCompraS) {
        this.fechaVencimientoCompraS = fechaVencimientoCompraS;
    }

    /**
     * @return the proveedor
     */
    public String getProveedor() {
        return proveedor;
    }

    /**
     * @param proveedor the proveedor to set
     */
    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    /**
     * @return the idCompraS
     */
    public String getIdCompraS() {
        return idCompraS;
    }

    /**
     * @param idCompraS the idCompraS to set
     */
    public void setIdCompraS(String idCompraS) {
        this.idCompraS = idCompraS;
    }
    
    
}
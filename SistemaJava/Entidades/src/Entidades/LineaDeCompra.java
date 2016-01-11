/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

/**
 *
 * @author Hamal
 */
public class LineaDeCompra {
  private long idLineaCompra;
  private String idLineaCompraS;
  private int cantidadLineaCompra;
  private String observacionLineaCompra;
  private double precioLineaCompra;
  private double pesoLineaCompra;
  private int idArticulo;
  private long idCompra;
  private String descripcionArticulo;
  private String descripcionCalidad;
  //precio por kg para mostrar en tabla
  private double precioCompra;
  private int cantidadFraccionada;
  private int idFraccionamiento;

    /**
     * @return the idLineaCompra
     */
    public long getIdLineaCompra() {
        return idLineaCompra;
    }

    /**
     * @param idLineaCompra the idLineaCompra to set
     */
    public void setIdLineaCompra(long idLineaCompra) {
        this.idLineaCompra = idLineaCompra;
    }

    /**
     * @return the cantidadLineaCompra
     */
    public int getCantidadLineaCompra() {
        return cantidadLineaCompra;
    }

    /**
     * @param cantidadLineaCompra the cantidadLineaCompra to set
     */
    public void setCantidadLineaCompra(int cantidadLineaCompra) {
        this.cantidadLineaCompra = cantidadLineaCompra;
    }

    /**
     * @return the observacionLineaCompra
     */
    public String getObservacionLineaCompra() {
        return observacionLineaCompra;
    }

    /**
     * @param observacionLineaCompra the observacionLineaCompra to set
     */
    public void setObservacionLineaCompra(String observacionLineaCompra) {
        this.observacionLineaCompra = observacionLineaCompra;
    }

    /**
     * @return the precioLineaCompra
     */
    public double getPrecioLineaCompra() {
        return precioLineaCompra;
    }

    /**
     * @param precioLineaCompra the precioLineaCompra to set
     */
    public void setPrecioLineaCompra(double precioLineaCompra) {
        this.precioLineaCompra = precioLineaCompra;
    }

    /**
     * @return the pesoLineaCompra
     */
    public double getPesoLineaCompra() {
        return pesoLineaCompra;
    }

    /**
     * @param pesoLineaCompra the pesoLineaCompra to set
     */
    public void setPesoLineaCompra(double pesoLineaCompra) {
        this.pesoLineaCompra = pesoLineaCompra;
    }

    /**
     * @return the idArticulo
     */
    public int getIdArticulo() {
        return idArticulo;
    }

    /**
     * @param idArticulo the idArticulo to set
     */
    public void setIdArticulo(int idArticulo) {
        this.idArticulo = idArticulo;
    }

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
     * @return the descripcionArticulo
     */
    public String getDescripcionArticulo() {
        return descripcionArticulo;
    }

    /**
     * @param descripcionArticulo the descripcionArticulo to set
     */
    public void setDescripcionArticulo(String descripcionArticulo) {
        this.descripcionArticulo = descripcionArticulo;
    }

    /**
     * @return the descripcionCalidad
     */
    public String getDescripcionCalidad() {
        return descripcionCalidad;
    }

    /**
     * @param descripcionCalidad the descripcionCalidad to set
     */
    public void setDescripcionCalidad(String descripcionCalidad) {
        this.descripcionCalidad = descripcionCalidad;
    }

    /**
     * @return the precioCompra
     */
    public double getPrecioCompra() {
        return precioCompra;
    }

    /**
     * @param precioCompra the precioCompra to set
     */
    public void setPrecioCompra(double precioCompra) {
        this.precioCompra = precioCompra;
    }

    /**
     * @return the cantidadFraccionada
     */
    public int getCantidadFraccionada() {
        return cantidadFraccionada;
    }

    /**
     * @param cantidadFraccionada the cantidadFraccionada to set
     */
    public void setCantidadFraccionada(int cantidadFraccionada) {
        this.cantidadFraccionada = cantidadFraccionada;
    }

    /**
     * @return the idLineaCompraS
     */
    public String getIdLineaCompraS() {
        return idLineaCompraS;
    }

    /**
     * @param idLineaCompraS the idLineaCompraS to set
     */
    public void setIdLineaCompraS(String idLineaCompraS) {
        this.idLineaCompraS = idLineaCompraS;
    }

    /**
     * @return the idFraccionamiento
     */
    public int getIdFraccionamiento() {
        return idFraccionamiento;
    }

    /**
     * @param idFraccionamiento the idFraccionamiento to set
     */
    public void setIdFraccionamiento(int idFraccionamiento) {
        this.idFraccionamiento = idFraccionamiento;
    }
}

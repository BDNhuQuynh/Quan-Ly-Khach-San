/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package qlkh_pojo;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class QLKHPOJO {
    private String maKH;
    private String tenKH;
    private String CMND;
    private Date ngaySinh;
    private String gioiTinh;
    private String SDT;

    public QLKHPOJO() {
    }

    public QLKHPOJO(String maKH, String tenKH, String CMND, Date ngaySinh, String gioiTinh, String SDT) {
        this.maKH = maKH;
        this.tenKH = tenKH;
        this.CMND = CMND;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.SDT = SDT;
    }
    
     public String getMaKH() {
        return maKH;
    }

    public void setMaKH(String maKH) {
        this.maKH = maKH;
    }
    
    public String getTenKH(){
        return tenKH;
    }
    public void setTenKH(String TenKH){
        this.tenKH = TenKH;
    }
    
     public String getCMND(){
        return CMND;
    }
    public void setCMND(String CMND){
        this.CMND = CMND;
    }
    
     public Date getNgaySinh(){
        return ngaySinh;
    }
    public void setNgaySinh(Date NgaySinh){
        this.ngaySinh = NgaySinh;
    }
    
     public String getGioiTinh(){
        return gioiTinh;
    }
    public void setGioiTinh(String GioiTinh){
        this.gioiTinh = GioiTinh;
    }
    
     public String getSDT(){
        return SDT;
    }
    public void setSDT(String SDT){
        this.SDT = SDT;
    }
}

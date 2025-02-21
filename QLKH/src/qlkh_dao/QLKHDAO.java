package qlkh_dao;

import java.sql.*;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import qlkh_pojo.QLKHPOJO;

public class QLKHDAO {

    public static ArrayList<QLKHPOJO> dsKhachHang() {
        ArrayList<QLKHPOJO> dsKH = new ArrayList<>();
       

        try {
            String sql ="Select * From KHACHHANG";
            KetNoi kn = new KetNoi();
            kn.open();
            ResultSet rs = kn.executeQuery(sql);
            System.out.println("Bắt đầu lấy dữ liệu từ cơ sở dữ liệu...");
            while (rs.next()) {
                QLKHPOJO kh = new QLKHPOJO();
                kh.setMaKH(rs.getString("MaKH"));
                kh.setTenKH(rs.getString("TenKH"));
                kh.setCMND(rs.getString("CMND"));
                kh.setNgaySinh(rs.getDate("NgaySinh"));
                kh.setGioiTinh(rs.getString("GioiTinh"));
                kh.setSDT(rs.getString("SDT"));
                dsKH.add(kh);
                System.out.println("Đã thêm khách hàng: " + kh.getMaKH()+ ", " + kh.getTenKH() + ", " + kh.getNgaySinh() + ", " + kh.getGioiTinh());
            }
            kn.close();
            System.out.println("Đã lấy xong dữ liệu. Số lượng khách hàng: " + dsKH.size());
        }catch(SQLException ex){
            ex.printStackTrace();
            System.out.println("Lỗi khi lấy dữ liệu: " + ex.getMessage());
            
        }
        return dsKH;
    }

    public static boolean themKhachHang(QLKHPOJO kh) {
        boolean kq = false;
        try {
            String sql = "{call themKhachHang(?,?,?,?,?)}";
            KetNoi dbSa = new KetNoi();
            dbSa.open();
            PreparedStatement ps = dbSa.prepareStatement(sql);
            ps.setString(1, kh.getTenKH());
            ps.setString(2, kh.getCMND());
            ps.setDate(3, new java.sql.Date(kh.getNgaySinh().getTime()));
            ps.setString(4, kh.getGioiTinh());
            ps.setString(5, kh.getSDT());
            ps.execute();
            dbSa.close();
            JOptionPane.showMessageDialog(null, "Thêm thành công gòi đó");

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
        }
        return kq;
    }
    
    public static boolean capNhatKhachHang(QLKHPOJO kh) {
        boolean kq = false;
        try {
            String sql = "{call updateKhachHang(?,?,?,?,?,?)}";
            KetNoi dbSa = new KetNoi();
            dbSa.open();
            PreparedStatement ps = dbSa.prepareStatement(sql);
            ps.setString(1, kh.getMaKH());
            ps.setString(2, kh.getTenKH());
            ps.setString(3, kh.getCMND());
            ps.setDate(4,  new java.sql.Date(kh.getNgaySinh().getTime()));
            ps.setString(5, kh.getGioiTinh());
            ps.setString(6, kh.getSDT());
            ps.execute();
            dbSa.close();
            JOptionPane.showMessageDialog(null, "Sửa thành công gòi nè béee");

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
        }
        return kq;
    }
    
    public static boolean xoaKhachHang(String makh) {
        boolean kq = false;
        try {
            String sql = "{call xoaKhachHang(?)}";
            KetNoi dbSa = new KetNoi();
            dbSa.open();
            PreparedStatement ps = dbSa.prepareStatement(sql);
            ps.setString(1, makh);
            ps.execute();
            dbSa.close();
            JOptionPane.showMessageDialog(null, "Xóa gòi nèeeee");

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
        }
        return kq;
    }
    
  
    
    public static ArrayList<QLKHPOJO> timKhachHang(String tenKH) {
        ArrayList<QLKHPOJO> dsKH = new ArrayList<QLKHPOJO>();
        try {
            String sql = "{call timKhachHang(?)}";
            KetNoi dbSa = new KetNoi();
            dbSa.open();
            PreparedStatement ps = dbSa.prepareStatement(sql);
            ps.setString(1, tenKH);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                QLKHPOJO kh = new QLKHPOJO();
                kh.setMaKH(rs.getString(1));
                kh.setTenKH(rs.getString(2));
                kh.setCMND(rs.getString(3));
                kh.setNgaySinh(rs.getDate(4));
                kh.setGioiTinh(rs.getString(5));
                kh.setSDT(rs.getString(6));
                dsKH.add(kh);
            }

            dbSa.close();
            JOptionPane.showMessageDialog(null, "Tìm thành công rồi bé ơi");

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, e);
        }
        return dsKH;
    }

    
}

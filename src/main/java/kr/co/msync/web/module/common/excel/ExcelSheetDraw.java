package kr.co.msync.web.module.common.excel;

import kr.co.msync.web.module.cate.model.res.CateResVO;
import kr.co.msync.web.module.color.model.res.ColorResVO;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.device.model.res.DeviceResVO;
import kr.co.msync.web.module.service.model.res.ServiceResVO;
import kr.co.msync.web.module.store.model.res.StoreResVO;
import kr.co.msync.web.module.user.model.res.UserResVO;
import kr.co.msync.web.module.util.StringUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.util.List;
import java.util.Map;

public class ExcelSheetDraw {

    private Map<String, Object> model;
    private ExcelDownType et;

    public ExcelSheetDraw(Map<String, Object> model){
        this.model = model;
        this.et = ExcelDownType.fromValue(model.get("excelDownType"));
    }

    public HSSFSheet excelFirstSheet(HSSFWorkbook workbook) {

        HSSFSheet sheet = workbook.createSheet();

        switch (et) {
            case 색상리스트 :
                workbook.setSheetName(0, ExcelDownType.색상리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            case 상품리스트 :
                workbook.setSheetName(0, ExcelDownType.상품리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            case 카테고리리스트 :
                workbook.setSheetName(0, ExcelDownType.카테고리리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            case 서비스리스트 :
                workbook.setSheetName(0, ExcelDownType.서비스리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            case 운영자리스트 :
                workbook.setSheetName(0, ExcelDownType.운영자리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            case 매장리스트 :
                workbook.setSheetName(0, ExcelDownType.매장리스트.name());
                /*sheet.setColumnWidth(1, 256*30);*/
                break;
            default :
        }

        return sheet;

    }

    public void excelColumnLable(HSSFSheet sheet) {
        HSSFRow firstRow = null;
        HSSFCell cell = null;
        switch (et) {
            case 색상리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("색상코드");

                cell = firstRow.createCell(1);
                cell.setCellValue("색상명");

                cell = firstRow.createCell(2);
                cell.setCellValue("REG 색상");

                cell = firstRow.createCell(3);
                cell.setCellValue("색상 순번");

                cell = firstRow.createCell(4);
                cell.setCellValue("사용여부");

                cell = firstRow.createCell(5);
                cell.setCellValue("삭제여부");

                cell = firstRow.createCell(6);
                cell.setCellValue("등록자 ID");

                cell = firstRow.createCell(7);
                cell.setCellValue("등록자");

                cell = firstRow.createCell(8);
                cell.setCellValue("등록일자");

                cell = firstRow.createCell(9);
                cell.setCellValue("수정자 ID");

                cell = firstRow.createCell(10);
                cell.setCellValue("수정자");

                cell = firstRow.createCell(11);
                cell.setCellValue("수정일자");

                break;
            case 상품리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("상품번호");
                cell = firstRow.createCell(1);
                cell.setCellValue("카테고리명");
                cell = firstRow.createCell(2);
                cell.setCellValue("상품명");
                cell = firstRow.createCell(3);
                cell.setCellValue("색상리스트");
                cell = firstRow.createCell(4);
                cell.setCellValue("사용여부");
                cell = firstRow.createCell(5);
                cell.setCellValue("삭제여부");
                cell = firstRow.createCell(6);
                cell.setCellValue("등록자 ID");
                cell = firstRow.createCell(7);
                cell.setCellValue("등록자");
                cell = firstRow.createCell(8);
                cell.setCellValue("등록일자");
                cell = firstRow.createCell(9);
                cell.setCellValue("수정자 ID");
                cell = firstRow.createCell(10);
                cell.setCellValue("수정자");
                cell = firstRow.createCell(11);
                cell.setCellValue("수정일자");
                break;
            case 카테고리리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("카테고리번호");

                cell = firstRow.createCell(1);
                cell.setCellValue("카테고리명");

                cell = firstRow.createCell(2);
                cell.setCellValue("판매여부");

                cell = firstRow.createCell(3);
                cell.setCellValue("교환여부");

                cell = firstRow.createCell(4);
                cell.setCellValue("삭제여부");

                cell = firstRow.createCell(5);
                cell.setCellValue("등록자 ID");

                cell = firstRow.createCell(6);
                cell.setCellValue("등록자");

                cell = firstRow.createCell(7);
                cell.setCellValue("등록일자");

                cell = firstRow.createCell(8);
                cell.setCellValue("수정자 ID");

                cell = firstRow.createCell(9);
                cell.setCellValue("수정자");

                cell = firstRow.createCell(10);
                cell.setCellValue("수정일자");

                break;
            case 서비스리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("서비스번호");

                cell = firstRow.createCell(1);
                cell.setCellValue("서비스구분");

                cell = firstRow.createCell(2);
                cell.setCellValue("서비스명");

                cell = firstRow.createCell(3);
                cell.setCellValue("사용여부");

                cell = firstRow.createCell(4);
                cell.setCellValue("삭제여부");

                cell = firstRow.createCell(5);
                cell.setCellValue("등록자 ID");

                cell = firstRow.createCell(6);
                cell.setCellValue("등록자");

                cell = firstRow.createCell(7);
                cell.setCellValue("등록일자");

                cell = firstRow.createCell(8);
                cell.setCellValue("수정자 ID");

                cell = firstRow.createCell(9);
                cell.setCellValue("수정자");

                cell = firstRow.createCell(10);
                cell.setCellValue("수정일자");

                break;
            case 운영자리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("운영자번호");

                cell = firstRow.createCell(1);
                cell.setCellValue("운영자(한글)명");

                cell = firstRow.createCell(2);
                cell.setCellValue("운영자(영문)명");

                cell = firstRow.createCell(3);
                cell.setCellValue("메일주소");

                cell = firstRow.createCell(4);
                cell.setCellValue("로그인아이디");

                cell = firstRow.createCell(5);
                cell.setCellValue("회사명");

                cell = firstRow.createCell(6);
                cell.setCellValue("운영자 권한");

                cell = firstRow.createCell(7);
                cell.setCellValue("관리채널");

                cell = firstRow.createCell(8);
                cell.setCellValue("사용자 상태");

                cell = firstRow.createCell(9);
                cell.setCellValue("등록유형");

                cell = firstRow.createCell(10);
                cell.setCellValue("삭제여부");

                cell = firstRow.createCell(11);
                cell.setCellValue("등록일자");

                cell = firstRow.createCell(12);
                cell.setCellValue("수정일자");

                break;
            case 매장리스트 :

                firstRow = sheet.createRow(0);

                cell = firstRow.createCell(0);
                cell.setCellValue("매장코드");

                cell = firstRow.createCell(1);
                cell.setCellValue("매장 타입");

                cell = firstRow.createCell(2);
                cell.setCellValue("매장 상태");

                cell = firstRow.createCell(3);
                cell.setCellValue("매장명");

                cell = firstRow.createCell(4);
                cell.setCellValue("매장 주소");

                cell = firstRow.createCell(5);
                cell.setCellValue("매장 상세 주소");

                cell = firstRow.createCell(6);
                cell.setCellValue("위도/경도");

                cell = firstRow.createCell(7);
                cell.setCellValue("찾아오는 길");

                cell = firstRow.createCell(8);
                cell.setCellValue("매장 전화번호");

                cell = firstRow.createCell(9);
                cell.setCellValue("주차 여부");

                cell = firstRow.createCell(10);
                cell.setCellValue("영업시간");

                cell = firstRow.createCell(11);
                cell.setCellValue("A/S시간");

                cell = firstRow.createCell(12);
                cell.setCellValue("매장 메시지");

                cell = firstRow.createCell(13);
                cell.setCellValue("매장 휴무");

                cell = firstRow.createCell(14);
                cell.setCellValue("영업 시간");

                cell = firstRow.createCell(15);
                cell.setCellValue("악세사리 취급 여부");

                cell = firstRow.createCell(16);
                cell.setCellValue("관리자 메모");

                cell = firstRow.createCell(17);
                cell.setCellValue("매장 사진");

                cell = firstRow.createCell(18);
                cell.setCellValue("판매기기");

                cell = firstRow.createCell(19);
                cell.setCellValue("교환기기");

                cell = firstRow.createCell(20);
                cell.setCellValue("제공 서비스");

                cell = firstRow.createCell(21);
                cell.setCellValue("등록일");

                cell = firstRow.createCell(22);
                cell.setCellValue("수정일");

                break;
            default :
        }

    }

    public void excelRowData(HSSFSheet sheet){

        HSSFRow row = null;
        HSSFCell cell = null;

        switch (et) {
            case 색상리스트 :
                List<ColorResVO> colorList = (List<ColorResVO>)model.get("excelList");
                for(int i = 0 ; i < colorList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(colorList.get(i).getNo_color());

                    cell = row.createCell(1);
                    cell.setCellValue(colorList.get(i).getColor_name());

                    cell = row.createCell(2);
                    cell.setCellValue(colorList.get(i).getColor_rgb());

                    cell = row.createCell(3);
                    cell.setCellValue(colorList.get(i).getColor_sno());

                    cell = row.createCell(4);
                    cell.setCellValue(colorList.get(i).getUse_yn());

                    cell = row.createCell(5);
                    cell.setCellValue(colorList.get(i).getUse_yn());

                    cell = row.createCell(6);
                    cell.setCellValue(colorList.get(i).getReg_id());

                    cell = row.createCell(7);
                    cell.setCellValue(colorList.get(i).getReg_name());

                    cell = row.createCell(8);
                    cell.setCellValue(StringUtil.getTimeStamp(colorList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(9);
                    cell.setCellValue(colorList.get(i).getMod_id());

                    cell = row.createCell(10);
                    cell.setCellValue(colorList.get(i).getMod_name());

                    cell = row.createCell(11);
                    cell.setCellValue(StringUtil.getTimeStamp(colorList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            case 상품리스트 :
                List<DeviceResVO> deviceList = (List<DeviceResVO>)model.get("excelList");
                for(int i = 0 ; i < deviceList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(deviceList.get(i).getNo_device());

                    cell = row.createCell(1);
                    cell.setCellValue(deviceList.get(i).getCate_name());

                    cell = row.createCell(2);
                    cell.setCellValue(deviceList.get(i).getDevice_name());

                    cell = row.createCell(3);
                    cell.setCellValue(deviceList.get(i).getColor_name_array());

                    cell = row.createCell(4);
                    cell.setCellValue(deviceList.get(i).getUse_yn());

                    cell = row.createCell(5);
                    cell.setCellValue(deviceList.get(i).getDel_yn());

                    cell = row.createCell(6);
                    cell.setCellValue(deviceList.get(i).getReg_id());

                    cell = row.createCell(7);
                    cell.setCellValue(deviceList.get(i).getReg_name());

                    cell = row.createCell(8);
                    cell.setCellValue(StringUtil.getTimeStamp(deviceList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(9);
                    cell.setCellValue(deviceList.get(i).getMod_id());

                    cell = row.createCell(10);
                    cell.setCellValue(deviceList.get(i).getMod_name());

                    cell = row.createCell(11);
                    cell.setCellValue(StringUtil.getTimeStamp(deviceList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            case 카테고리리스트 :
                List<CateResVO> cateList = (List<CateResVO>)model.get("excelList");
                for(int i = 0 ; i < cateList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(cateList.get(i).getNo_cate());

                    cell = row.createCell(1);
                    cell.setCellValue(cateList.get(i).getCate_name());

                    cell = row.createCell(2);
                    cell.setCellValue(cateList.get(i).getSell_yn());

                    cell = row.createCell(3);
                    cell.setCellValue(cateList.get(i).getExcg_yn());

                    cell = row.createCell(4);
                    cell.setCellValue(cateList.get(i).getDel_yn());

                    cell = row.createCell(5);
                    cell.setCellValue(cateList.get(i).getReg_id());

                    cell = row.createCell(6);
                    cell.setCellValue(cateList.get(i).getReg_name());

                    cell = row.createCell(7);
                    cell.setCellValue(StringUtil.getTimeStamp(cateList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(8);
                    cell.setCellValue(cateList.get(i).getMod_id());

                    cell = row.createCell(9);
                    cell.setCellValue(cateList.get(i).getMod_name());

                    cell = row.createCell(10);
                    cell.setCellValue(StringUtil.getTimeStamp(cateList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            case 서비스리스트 :
                List<ServiceResVO> serviceList = (List<ServiceResVO>)model.get("excelList");
                for(int i = 0 ; i < serviceList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(serviceList.get(i).getNo_service());

                    cell = row.createCell(1);
                    cell.setCellValue(serviceList.get(i).getService_div());

                    cell = row.createCell(2);
                    cell.setCellValue(serviceList.get(i).getService_name());

                    cell = row.createCell(3);
                    cell.setCellValue(serviceList.get(i).getUse_yn());

                    cell = row.createCell(4);
                    cell.setCellValue(serviceList.get(i).getDel_yn());

                    cell = row.createCell(5);
                    cell.setCellValue(serviceList.get(i).getReg_id());

                    cell = row.createCell(6);
                    cell.setCellValue(serviceList.get(i).getReg_name());

                    cell = row.createCell(7);
                    cell.setCellValue(StringUtil.getTimeStamp(serviceList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(8);
                    cell.setCellValue(serviceList.get(i).getMod_id());

                    cell = row.createCell(9);
                    cell.setCellValue(serviceList.get(i).getMod_name());

                    cell = row.createCell(10);
                    cell.setCellValue(StringUtil.getTimeStamp(serviceList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            case 운영자리스트 :
                List<UserResVO> userList = (List<UserResVO>)model.get("excelList");
                for(int i = 0 ; i < userList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(userList.get(i).getNo_user());

                    cell = row.createCell(1);
                    cell.setCellValue(userList.get(i).getUser_name());

                    cell = row.createCell(2);
                    cell.setCellValue(userList.get(i).getUser_en_name());

                    cell = row.createCell(3);
                    cell.setCellValue(userList.get(i).getEmail_addr());

                    cell = row.createCell(4);
                    cell.setCellValue(userList.get(i).getLogin_id());

                    cell = row.createCell(5);
                    cell.setCellValue(userList.get(i).getUser_company());

                    cell = row.createCell(6);
                    cell.setCellValue(userList.get(i).getUser_grt());

                    cell = row.createCell(7);
                    cell.setCellValue(userList.get(i).getUser_channel());

                    cell = row.createCell(8);
                    cell.setCellValue(userList.get(i).getUser_status());

                    cell = row.createCell(9);
                    cell.setCellValue(userList.get(i).getReg_way());

                    cell = row.createCell(10);
                    cell.setCellValue(userList.get(i).getDel_yn());

                    cell = row.createCell(11);
                    cell.setCellValue(StringUtil.getTimeStamp(userList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(12);
                    cell.setCellValue(StringUtil.getTimeStamp(userList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            case 매장리스트 :
                List<StoreResVO> storeList = (List<StoreResVO>)model.get("excelList");
                for(int i = 0 ; i < storeList.size() ; i++) {

                    row = sheet.createRow(i + 1);
                    cell = row.createCell(0);
                    cell.setCellValue(storeList.get(i).getStore_code());

                    cell = row.createCell(1);
                    cell.setCellValue(storeList.get(i).getStore_type());

                    cell = row.createCell(2);
                    cell.setCellValue(storeList.get(i).getStore_status());

                    cell = row.createCell(3);
                    cell.setCellValue(storeList.get(i).getStore_name());

                    cell = row.createCell(4);
                    cell.setCellValue(storeList.get(i).getStore_addr());

                    cell = row.createCell(5);
                    cell.setCellValue(storeList.get(i).getStore_addr_dtl());

                    cell = row.createCell(6);
                    cell.setCellValue(storeList.get(i).getLatitude()+","+storeList.get(i).getLongitude());

                    cell = row.createCell(7);
                    cell.setCellValue(storeList.get(i).getCome_way());

                    cell = row.createCell(8);
                    cell.setCellValue(storeList.get(i).getTel_num());

                    cell = row.createCell(9);
                    cell.setCellValue(storeList.get(i).getParking_yn());

                    cell = row.createCell(10);
                    cell.setCellValue(storeList.get(i).getOper_time());

                    cell = row.createCell(11);
                    cell.setCellValue(storeList.get(i).getAs_time());

                    cell = row.createCell(12);
                    cell.setCellValue(storeList.get(i).getNotice());

                    cell = row.createCell(13);
                    cell.setCellValue(storeList.get(i).getClosed_date());

                    cell = row.createCell(14);
                    cell.setCellValue(storeList.get(i).getOper_week_time());

                    cell = row.createCell(15);
                    cell.setCellValue(storeList.get(i).getTreat_yn());

                    cell = row.createCell(16);
                    cell.setCellValue(storeList.get(i).getCust_desc());

                    cell = row.createCell(17);
                    cell.setCellValue(storeList.get(i).getFile_map_array());

                    cell = row.createCell(18);
                    cell.setCellValue(storeList.get(i).getSell_array());

                    cell = row.createCell(19);
                    cell.setCellValue(storeList.get(i).getExcg_array());

                    cell = row.createCell(20);
                    cell.setCellValue(storeList.get(i).getService_map_array());

                    cell = row.createCell(21);
                    cell.setCellValue(StringUtil.getTimeStamp(storeList.get(i).getReg_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                    cell = row.createCell(22);
                    cell.setCellValue(StringUtil.getTimeStamp(storeList.get(i).getMod_date(),"yyyyMMddHHmmss", "yyyy-MM-dd HH:mm:ss"));

                }
                break;
            default :
        }

    }
}

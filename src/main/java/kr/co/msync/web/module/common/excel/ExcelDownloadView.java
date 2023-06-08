package kr.co.msync.web.module.common.excel;

import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.store.model.req.StoreReqVO;
import kr.co.msync.web.module.util.SessionUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

public class ExcelDownloadView extends AbstractExcelView {

    @SuppressWarnings("unchecked")
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest req, HttpServletResponse res) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat( "yyyyMMdd");
        Calendar time = Calendar.getInstance();
        String date = sdf.format(time.getTime());

        String userAgent = req.getHeader("User-Agent");
        String fileName = date + "_" + ExcelDownType.fromValue(model.get("excelDownType")).name().toString() + ".xls";

        if(userAgent.indexOf("MSIE") > -1){
            fileName = URLEncoder.encode(fileName, "utf-8");
        }else{
            fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
        }

        res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        res.setHeader("Content-Transfer-Encoding", "binary");

        ExcelSheetDraw esd = new ExcelSheetDraw(model);

        HSSFSheet sheet = esd.excelFirstSheet(workbook);

        esd.excelColumnLable(sheet);

        esd.excelRowData(sheet);


    }

}

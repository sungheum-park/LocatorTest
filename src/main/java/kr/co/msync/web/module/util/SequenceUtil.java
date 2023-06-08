package kr.co.msync.web.module.util;

import java.util.HashMap;
import java.util.Map;

public class SequenceUtil {

    private static SequenceUtil sequenceUtil;
    private static Map<String, String[]> map = new HashMap();

    private static final String[][] valueArr = {
            {"tb_store_master","STORE_CODE","10"},
            {"tb_service","NO_SERVICE","3"},
            {"tb_category","NO_CATE","7"},
            {"tb_device_master","NO_DEVICE","5"},
            {"tb_device_color","NO_COLOR","3"},
            {"tb_user","NO_USER","5"},
            {"tb_menu","NO_MENU","3"}
    };

    public static synchronized SequenceUtil getInstance() {
        if (sequenceUtil == null) {
            sequenceUtil = new SequenceUtil();
        }
        return sequenceUtil;
    }

    public SequenceUtil(){
        map.put("TB_STORE_MASTER", valueArr[0]);
        map.put("TB_SERVICE", valueArr[1]);
        map.put("TB_CATEGORY", valueArr[2]);
        map.put("TB_DEVICE_MASTER", valueArr[3]);
        map.put("TB_DEVICE_COLOR", valueArr[4]);
        map.put("TB_USER", valueArr[5]);
        map.put("TB_MENU", valueArr[6]);
    }

    public static Map<String, Object> getSequence(String tableName) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String[] entity = map.get(tableName);
        resultMap.put("tableName", entity[0]);
        resultMap.put("col", entity[1]);
        resultMap.put("numCnt", entity[2]);
        return resultMap;
    }

}

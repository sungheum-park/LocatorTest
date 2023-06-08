package kr.co.msync.web.module.util;

import kr.co.msync.web.module.common.dao.CodeMapper;
import kr.co.msync.web.module.common.model.req.CodeReqVO;
import kr.co.msync.web.module.common.model.res.CodeResVO;

import java.util.List;

public class JSTLFunction {

    /**
     * ApplicationContext 빈 가져오기
     *
     * @param bean
     * @return
     */
    private static Object getBean(String bean) {
        return SpringApplicationContext.getBean(bean);
    }

    public static String getSelectBox(String code_group, String yn_use, String input_name, Boolean isHead, String code_value) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");
        StringBuffer data = new StringBuffer();

        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setCode_group(code_group);
        reqVO.setUse_yn(yn_use);
        List<CodeResVO> list = codeMapper.getCodeList(reqVO);
        if (list == null)
            return data.toString();

        // Select Box header
        data.append("<select class='hidden_option' name='" + input_name + "'>");

        if (isHead) {
            data.append(addOptionHead());
        }
        for (CodeResVO resVO : list) {
            String val = resVO.getCode_value();
            String name = resVO.getCode_name();
            data.append(addOptionItem(val, name, code_value));
        }

        // Select Box footer
        data.append("</select>");

        return data.toString();
    }

    public static String getStoreSelectBox(String code_group, String yn_use, String input_name, Boolean isHead, String code_value, String inclusive_code) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");
        StringBuffer data = new StringBuffer();

        // code테이블에서 code값 Select
        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setCode_group(code_group);
        reqVO.setUse_yn(yn_use);

        // Code Select List
        List<CodeResVO> list = codeMapper.getCodeList(reqVO);

        // list 사이즈 체크
        if (list.isEmpty())
            return data.toString();

        // Select Box header
        data.append("<select class='hidden_option' name='" + input_name + "'>");
        if (isHead) {
            data.append(addOptionHead());
        }

        for (CodeResVO resVO : list) {
            String val = resVO.getCode_value(); // 코드 값
            String name = resVO.getCode_name(); // 코드 네임
            data.append(addStoreOptionItem(val, name, code_value, inclusive_code));
        }
        // Select Box footer
        data.append("</select>");
        return data.toString();
    }

    public static String getCodeName(String code_group, String code_value) {

        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");

        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setCode_group(code_group);
        reqVO.setCode_value(code_value);

        String name = codeMapper.getCodeName(reqVO);
        return StringUtil.changeNulltoEmptyString(name);
    }

    public static String getCodeNameArr(String code_group, String code_value) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");
        String name = "";
        String[] codeValueArr = code_value.split(",");
        for (int i = 0; i < codeValueArr.length; i++) {
            String chkValue = codeValueArr[i];
            CodeReqVO reqVO = new CodeReqVO();
            reqVO.setCode_group(code_group);
            reqVO.setCode_value(chkValue);
            String value = codeMapper.getCodeName(reqVO);
            if (value != null) {
                name += value;
                if (i != codeValueArr.length - 1) {
                    name += "<br/>";
                }
            }
        }
        return StringUtil.changeNulltoEmptyString(name);
    }


    private static String addOptionHead() {
        return "<option value=''>전체</option>";
    }

    private static String addOptionItem(String val, String text, String code_value) {
        if (val.equals(code_value)) {
            return "<option selected='selected' value='" + val + "'>" + text + "</option>";
        } else {
            return "<option value='" + val + "'>" + text + "</option>";
        }
    }

    private static String addStoreOptionItem(String val, String name, String code_value, String inclusive_code) {
        if (inclusive_code == null || inclusive_code.equals("")) {
            if (val.equals(code_value)) {
                return "<option selected='selected' value='" + val + "'>" + name + "</option>";
            } else {
                return "<option value='" + val + "'>" + name + "</option>";
            }
        }

        if (inclusive_code.contains(val)) {
            if (val.equals(code_value)) {
                return "<option selected='selected' value='" + val + "'>" + name + "</option>";
            } else {
                return "<option value='" + val + "'>" + name + "</option>";
            }
        }
        return "";
    }

    private static String addRadioItem(String name, String val, String text, String code_value) {
        if (val.equals(code_value)) {
            return "<div class='radio_wrap'> <input type='radio' value='" + val + "' name='" + name + "' checked> <label>" + text + "</label></div>";

        } else {
            return "<div class='radio_wrap'> <input type='radio' value='" + val + "' name='" + name + "'> <label>" + text + "</label></div>";
        }
    }

    private static String addCheckItem(String name, String val, String text, String code_value) {
            if (code_value.contains(val)) {
            return "<div class='Check_wrap'> <input type='checkbox'  value='" + val + "' name='" + name + "'  id='" + "chk" + "" + val + "' checked> <label for='" + "chk" + val + "'>" + text + "</label></div>";

        } else {
            return "<div class='Check_wrap'> <input type='checkbox'  value='" + val + "' name='" + name + "' id='" + "chk" + "" + val + "'> <label for='" + "chk" + "" + val + "' >" + text + "</label></div>";
        }
    }

    public static String getRadioButton(String code_group, String yn_use, String input_name, String code_value, String exclusive) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");
        StringBuffer data = new StringBuffer();

        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setCode_group(code_group);
        reqVO.setUse_yn(yn_use);
        List<CodeResVO> list = codeMapper.getCodeList(reqVO);
        if (list == null)
            return data.toString();

        for (CodeResVO resVO : list) {
            String val = resVO.getCode_value();
            String name = resVO.getCode_name();
            if (!exclusive.contains(val)) {
                data.append(addRadioItem(input_name, val, name, code_value));
            }
        }

        return data.toString();
    }

    public static String getCheckBox(String code_group, String yn_use, String input_name, String code_value) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper"); // Object타입으로 반환
        StringBuffer data = new StringBuffer(); // 독립적인 공간 (append() 사용하여 추가)

        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setCode_group(code_group);
        reqVO.setUse_yn(yn_use);
        List<CodeResVO> list = codeMapper.getCodeList(reqVO);
        if (list == null)
            return data.toString();

        for (CodeResVO resVO : list) {
            String val = resVO.getCode_value();
            String name = resVO.getCode_name();
            data.append(addCheckItem(input_name, val, name, code_value));
        }

        return data.toString();
    }

    public static String getSelectByTable(String table_name, String input_name, String column_pk, String column_name, String del_yn, Boolean isHead, String value) {
        CodeMapper codeMapper = (CodeMapper) getBean("codeMapper");
        StringBuffer data = new StringBuffer();

        CodeReqVO reqVO = new CodeReqVO();
        reqVO.setTable_name(table_name);
        reqVO.setColumn_pk(column_pk);
        reqVO.setColumn_name(column_name);
        reqVO.setDel_yn(del_yn);
        List<CodeResVO> list = codeMapper.getCodeNameByTable(reqVO);
        if (list == null)
            return data.toString();

        // Select Box header
        data.append("<select class='hidden_option' name='" + input_name + "'>");

        if (isHead) {
            data.append(addOptionHead());
        }
        for (CodeResVO resVO : list) {
            String val = resVO.getColumn_pk();
            String name = resVO.getColumn_name();
            data.append(addOptionItem(val, name, value));
        }

        // Select Box footer
        data.append("</select>");

        return data.toString();
    }


}

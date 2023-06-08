package kr.co.msync.web.module.common.model;

import org.apache.commons.lang.StringUtils;

public class Criteria {

    private int page;  		    // 보여줄 페이지 번호
    private int perPageNum;   // 페이지당 보여줄 게시글의 개수

    private String order_column;
    private String order_type;

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
            return;
        }

        this.page = page;
    }

    public int getPerPageNum() {
        return perPageNum;
    }

    public void setPerPageNum(int perPageNum) {

        if(perPageNum <= 0 || perPageNum > 1000) {
            this.perPageNum = 10;
            return;
        }

        this.perPageNum = perPageNum;
    }

    public int getPageStart() {
        return (this.page -1) * perPageNum;
    }

    public String getOrder_column() {
        return order_column;
    }

    public void setOrder_column(String order_column) {
        this.order_column = order_column;
    }

    public String getOrder_type() {
        return order_type;
    }

    public void setOrder_type(String order_type) {
        this.order_type = order_type;
    }
}

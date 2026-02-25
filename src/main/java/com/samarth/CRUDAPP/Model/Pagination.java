package com.samarth.CRUDAPP.Model;

public class Pagination {
    int pagenumber;
    int pagesize;

    public Pagination() {
    }

    public Pagination(int pagenumber, int pagesize) {
        this.pagenumber = pagenumber;
        this.pagesize = pagesize;
    }

    public int getPagenumber() {
        return pagenumber;
    }

    public void setPagenumber(int pagenumber) {
        this.pagenumber = pagenumber;
    }

    public int getPagesize() {
        return pagesize;
    }

    public void setPagesize(int pagesize) {
        this.pagesize = pagesize;
    }

    @Override
    public String toString() {
        return "pagination{" +
                "pagenumber=" + pagenumber +
                ", pagesize=" + pagesize +
                '}';
    }

    public int getOffest(){
        return (pagenumber-1)*pagesize;
    }

}

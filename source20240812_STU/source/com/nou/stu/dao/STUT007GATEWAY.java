package com.nou.stu.dao;

import com.acer.db.DBManager;
import com.acer.db.query.DBResult;
import com.acer.util.Utility;
import com.acer.apps.Page;

import java.sql.Connection;
import java.util.Vector;
import java.util.Hashtable;

/*
 * (STUT007) Gateway/*
 *-------------------------------------------------------------------------------*
 * Author    : 國長      2007/05/04
 * Modification Log :
 * Vers     Date           By             Notes
 *--------- -------------- -------------- ----------------------------------------
 * V0.0.1   2007/05/04     國長           建立程式
 *                                        新增 getStut007ForUse(Hashtable ht)
 * V0.0.2   2007/09/04     poto           新增 getStut007Query(Hashtable ht)
 * V0.0.3	2007/09/05	   tonny	      新增stu101m_1(Hashtable ht)
 * V0.0.4   2007/09/07     poto           新增 getStut007QueryEdit(Hashtable ht)
 * V0.0.5   2007/09/07     poto           修改 getStut007QueryEdit(Hashtable ht)
 *--------------------------------------------------------------------------------
 */
public class STUT007GATEWAY {

    /** 資料排序方式 */
    private String orderBy = "";
    private DBManager dbmanager = null;
    private Connection conn = null;
    /* 頁數 */
    private int pageNo = 0;
    /** 每頁筆數 */
    private int pageSize = 0;

    /** 記錄是否分頁 */
    private boolean pageQuery = false;

    /** 用來存放 SQL 語法的物件 */
    private StringBuffer sql = new StringBuffer();

    /** <pre>
     *  設定資料排序方式.
     *  Ex: "AYEAR, SMS DESC"
     *      先以 AYEAR 排序再以 SMS 倒序序排序
     *  </pre>
     */
    public void setOrderBy(String orderBy) {
        if(orderBy == null) {
            orderBy = "";
        }
        this.orderBy = orderBy;
    }

    /** 取得總筆數 */
    public int getTotalRowCount() {
        return Page.getTotalRowCount();
    }

    /** 不允許建立空的物件 */
    private STUT007GATEWAY() {}

    /** 建構子，查詢全部資料用 */
    public STUT007GATEWAY(DBManager dbmanager, Connection conn) {
        this.dbmanager = dbmanager;
        this.conn = conn;
    }

    /** 建構子，查詢分頁資料用 */
    public STUT007GATEWAY(DBManager dbmanager, Connection conn, int pageNo, int pageSize) {
        this.dbmanager = dbmanager;
        this.conn = conn;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        pageQuery = true;
    }

    /**
     *
     * @param ht 條件值
     * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
     *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
     *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
     * @throws Exception
     */
    public Vector getStut007ForUse(Hashtable ht) throws Exception {
        if(ht == null) {
            ht = new Hashtable();
        }
        Vector result = new Vector();
        if(sql.length() > 0) {
            sql.delete(0, sql.length());
        }
        sql.append(
            "SELECT S07.ASYS, S07.AYEAR, S07.SMS, S07.STNO, S07.CENTER_CODE, S07.APP_DATE, S07.FACTOR_CODE, S07.PAID_AMT, S07.REFUND_RATE, S07.LAB_FEE, S07.CRD_MISC_FEE, S07.MAG_FEE, S07.TOT_AMT, S07.RMK, S07.POST_NO, S07.POST_ACNT, S07.BANK_CODE, S07.BANK_ACNT, S07.REFUND_STATUS, S07.REFUND_METHOD, S07.RECEIVER_NAME, S07.RECEIVER_IDNO, S07.RECEIVER_ADDR_ZIP, S07.RECEIVER_ADDR, S07.REFUND_DOC_NO, S07.PRT_DATE, S07.RENDER_INVOICE_MK, S07.IS_REISSUE_PAYMENT_ID, S07.UPD_DATE, S07.UPD_TIME, S07.UPD_USER_ID, S07.ROWSTAMP " +
            "FROM STUT007 S07 " +
            "WHERE 1 = 1 "
        );
        if(!Utility.nullToSpace(ht.get("ASYS")).equals("")) {
            sql.append("AND S07.ASYS = '" + Utility.nullToSpace(ht.get("ASYS")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("AYEAR")).equals("")) {
            sql.append("AND S07.AYEAR = '" + Utility.nullToSpace(ht.get("AYEAR")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("SMS")).equals("")) {
            sql.append("AND S07.SMS = '" + Utility.nullToSpace(ht.get("SMS")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("STNO")).equals("")) {
            sql.append("AND S07.STNO = '" + Utility.nullToSpace(ht.get("STNO")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("CENTER_CODE")).equals("")) {
            sql.append("AND S07.CENTER_CODE = '" + Utility.nullToSpace(ht.get("CENTER_CODE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("APP_DATE")).equals("")) {
            sql.append("AND S07.APP_DATE = '" + Utility.nullToSpace(ht.get("APP_DATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("FACTOR_CODE")).equals("")) {
            sql.append("AND S07.FACTOR_CODE = '" + Utility.nullToSpace(ht.get("FACTOR_CODE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("PAID_AMT")).equals("")) {
            sql.append("AND S07.PAID_AMT = '" + Utility.nullToSpace(ht.get("PAID_AMT")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("REFUND_RATE")).equals("")) {
            sql.append("AND S07.REFUND_RATE = '" + Utility.nullToSpace(ht.get("REFUND_RATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("LAB_FEE")).equals("")) {
            sql.append("AND S07.LAB_FEE = '" + Utility.nullToSpace(ht.get("LAB_FEE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("CRD_MISC_FEE")).equals("")) {
            sql.append("AND S07.CRD_MISC_FEE = '" + Utility.nullToSpace(ht.get("CRD_MISC_FEE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("MAG_FEE")).equals("")) {
            sql.append("AND S07.MAG_FEE = '" + Utility.nullToSpace(ht.get("MAG_FEE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("TOT_AMT")).equals("")) {
            sql.append("AND S07.TOT_AMT = '" + Utility.nullToSpace(ht.get("TOT_AMT")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RMK")).equals("")) {
            sql.append("AND S07.RMK = '" + Utility.nullToSpace(ht.get("RMK")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("POST_NO")).equals("")) {
            sql.append("AND S07.POST_NO = '" + Utility.nullToSpace(ht.get("POST_NO")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("POST_ACNT")).equals("")) {
            sql.append("AND S07.POST_ACNT = '" + Utility.nullToSpace(ht.get("POST_ACNT")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("BANK_CODE")).equals("")) {
            sql.append("AND S07.BANK_CODE = '" + Utility.nullToSpace(ht.get("BANK_CODE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("BANK_ACNT")).equals("")) {
            sql.append("AND S07.BANK_ACNT = '" + Utility.nullToSpace(ht.get("BANK_ACNT")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("REFUND_STATUS")).equals("")) {
            sql.append("AND S07.REFUND_STATUS = '" + Utility.nullToSpace(ht.get("REFUND_STATUS")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("REFUND_METHOD")).equals("")) {
            sql.append("AND S07.REFUND_METHOD = '" + Utility.nullToSpace(ht.get("REFUND_METHOD")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RECEIVER_NAME")).equals("")) {
            sql.append("AND S07.RECEIVER_NAME = '" + Utility.nullToSpace(ht.get("RECEIVER_NAME")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RECEIVER_IDNO")).equals("")) {
            sql.append("AND S07.RECEIVER_IDNO = '" + Utility.nullToSpace(ht.get("RECEIVER_IDNO")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RECEIVER_ADDR_ZIP")).equals("")) {
            sql.append("AND S07.RECEIVER_ADDR_ZIP = '" + Utility.nullToSpace(ht.get("RECEIVER_ADDR_ZIP")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RECEIVER_ADDR")).equals("")) {
            sql.append("AND S07.RECEIVER_ADDR = '" + Utility.nullToSpace(ht.get("RECEIVER_ADDR")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("REFUND_DOC_NO")).equals("")) {
            sql.append("AND S07.REFUND_DOC_NO = '" + Utility.nullToSpace(ht.get("REFUND_DOC_NO")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("PRT_DATE")).equals("")) {
            sql.append("AND S07.PRT_DATE = '" + Utility.nullToSpace(ht.get("PRT_DATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("RENDER_INVOICE_MK")).equals("")) {
            sql.append("AND S07.RENDER_INVOICE_MK = '" + Utility.nullToSpace(ht.get("RENDER_INVOICE_MK")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("IS_REISSUE_PAYMENT_ID")).equals("")) {
            sql.append("AND S07.IS_REISSUE_PAYMENT_ID = '" + Utility.nullToSpace(ht.get("IS_REISSUE_PAYMENT_ID")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_DATE")).equals("")) {
            sql.append("AND S07.UPD_DATE = '" + Utility.nullToSpace(ht.get("UPD_DATE")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_TIME")).equals("")) {
            sql.append("AND S07.UPD_TIME = '" + Utility.nullToSpace(ht.get("UPD_TIME")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("UPD_USER_ID")).equals("")) {
            sql.append("AND S07.UPD_USER_ID = '" + Utility.nullToSpace(ht.get("UPD_USER_ID")) + "' ");
        }
        if(!Utility.nullToSpace(ht.get("ROWSTAMP")).equals("")) {
            sql.append("AND S07.ROWSTAMP = '" + Utility.nullToSpace(ht.get("ROWSTAMP")) + "' ");
        }

        if(!orderBy.equals("")) {
            String[] orderByArray = orderBy.split(",");
            orderBy = "";
            for(int i = 0; i < orderByArray.length; i++) {
                orderByArray[i] = "S07." + orderByArray[i].trim();

                if(i == 0) {
                    orderBy += "ORDER BY ";
                } else {
                    orderBy += ", ";
                }
                orderBy += orderByArray[i].trim();
            }
            sql.append(orderBy.toUpperCase());
            orderBy = "";
        }

        DBResult rs = null;
        try {
            if(pageQuery) {
                // 依分頁取出資料
                rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
            } else {
                // 取出所有資料
                rs = dbmanager.getSimpleResultSet(conn);
                rs.open();
                rs.executeQuery(sql.toString());
            }
            Hashtable rowHt = null;
            while (rs.next()) {
                rowHt = new Hashtable();
                /** 將欄位抄一份過去 */
                for (int i = 1; i <= rs.getColumnCount(); i++)
                    rowHt.put(rs.getColumnName(i), rs.getString(i));

                result.add(rowHt);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if(rs != null) {
                rs.close();
            }
        }
        return result;
    }



   /**
     *
     * @param ht 條件值
     * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
     *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
     *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
     * @throws Exception
     */
    public DBResult getStut007Query(Hashtable requestMap) throws Exception {
        if(requestMap == null) {
            requestMap = new Hashtable();
        }
        String  CENTER_CODE = Utility.checkNull((String)requestMap.get("CENTER_CODE2"), "");//中心
        Vector result = new Vector();
        if(sql.length() > 0) {
            sql.delete(0, sql.length());
        }
		sql.append("SELECT A.PRT_DATE,A.ASYS, A.AYEAR, A.SMS, A.STNO, A.CENTER_CODE, A.TOT_AMT, A.APP_DATE,D.NAME,D.IDNO,A.STCARD_STATUS, ");
		sql.append("(SELECT E.CODE_NAME FROM SYST001 E WHERE E.KIND='REFUND_STATUS' AND E.CODE=A.REFUND_STATUS) REFUND_STATUS_NAME, ");
		sql.append("(SELECT B.CENTER_ABBRNAME FROM SYST002 B WHERE B.CENTER_CODE=A.CENTER_CODE) CENTER_CODE_DESC ");
		sql.append("FROM STUT007 A ");
		sql.append("JOIN STUT003 C ON A.STNO = C.STNO ");
		sql.append("JOIN STUT002 D ON C.IDNO = D.IDNO AND C.BIRTHDATE = D.BIRTHDATE ");
		sql.append("WHERE 1=1 ");

		/** == 查詢條件 ST == */
  sql.append(" AND A.ASYS = '").append(requestMap.get("ASYS")).append("'");
		if(!Utility.checkNull(requestMap.get("AYEAR"), "").equals(""))
			sql.append("AND A.AYEAR	=	'").append(Utility.dbStr(requestMap.get("AYEAR"))).append("'");
		if(!Utility.checkNull(requestMap.get("SMS"), "").equals(""))
			sql.append("AND A.SMS	=	'").append(Utility.dbStr(requestMap.get("SMS"))).append("'");
		if(!Utility.checkNull(requestMap.get("IDNO"), "").equals(""))
			sql.append("AND C.IDNO	=	'").append(Utility.dbStr(requestMap.get("IDNO"))).append("'");
		if(!Utility.checkNull(requestMap.get("STNO"), "").equals(""))
			sql.append("AND A.STNO	=	'").append(Utility.dbStr(requestMap.get("STNO"))).append("'");
		if(!Utility.checkNull(requestMap.get("FACTOR_CODE"), "").equals(""))
			sql.append("AND A.FACTOR_CODE	=	'").append(Utility.dbStr(requestMap.get("FACTOR_CODE"))).append("'");
        /*
		if (!"".equals(CENTER_CODE))
        {
            CENTER_CODE = CENTER_CODE.substring(0,CENTER_CODE.length()-1);
            sql.append("AND c.CENTER_CODE IN (" + CENTER_CODE + ") ");
        }
        */
		/** == 查詢條件 ED == */
		sql.append(" ORDER BY A.ASYS, A.AYEAR, A.SMS, A.STNO");
        if(!orderBy.equals("")) {
            String[] orderByArray = orderBy.split(",");
            orderBy = "";
            for(int i = 0; i < orderByArray.length; i++) {
                orderByArray[i] = "S07." + orderByArray[i].trim();

                if(i == 0) {
                    orderBy += "ORDER BY ";
                } else {
                    orderBy += ", ";
                }
                orderBy += orderByArray[i].trim();
            }
            sql.append(orderBy.toUpperCase());
            orderBy = "";
        }

        DBResult rs = null;
//        try {
//            if(pageQuery) {
//                // 依分頁取出資料
//                rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
//            } else {
//                // 取出所有資料
//                rs = dbmanager.getSimpleResultSet(conn);
//                rs.open();
//                rs.executeQuery(sql.toString());
//            }
//            Hashtable rowHt = null;
//            while (rs.next()) {
//                rowHt = new Hashtable();
//                /** 將欄位抄一份過去 */
//                for (int i = 1; i <= rs.getColumnCount(); i++)
//                    rowHt.put(rs.getColumnName(i), rs.getString(i));
//
//                result.add(rowHt);
//            }
//
//        } catch (Exception e) {
//            throw e;
//        } finally {
//            if(rs != null) {
//                rs.close();
//            }
//        }

        rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
        return rs;
    }

    /**
    *
    * @param ht 條件值
    * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
    *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
    *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
    * @throws Exception
    */
   public String stu101m_1(Hashtable requestMap,String ASYS) throws Exception {
       if(requestMap == null) {
           requestMap = new Hashtable();
       }

       if(sql.length() > 0) {
           sql.delete(0, sql.length());
       }
	   //SQL語法 STU101M和STU211M應相同(若有變動應同步調整stu211m)    2008/08/26 by barry
       	sql.append("SELECT A.AYEAR,A.SMS,A.FACTOR_CODE,A.CENTER_CODE,A.STCARD_STATUS AS STCARD_STATUS, ");
		sql.append("(SELECT B.CENTER_ABBRNAME FROM SYST002 B WHERE B.CENTER_CODE=A.CENTER_CODE) CENTER_CODE_DESC, ");
		sql.append("D.NAME,A.STNO,LAB_FEE,CRD_MISC_FEE,MAG_FEE,TOT_AMT,E.CODE AS REFUND_STATUS,E.CODE_NAME AS REFUND_STATUS_DESC,G.CODE_NAME AS STTYPE_DESC,A.APP_DATE, ");
		sql.append("A.PRT_DATE, A.CHKLIST_NO, H.LOCK_MK, ");
		sql.append("B.DOC_NO AS DOC_NO,A.REFUND_DOC_NO ");
		sql.append("FROM STUT007 A ");
		sql.append("LEFT JOIN STUT008 B ON A.STNO = B.STNO AND A.AYEAR = B.AYEAR AND A.SMS = B.SMS ");
		sql.append("LEFT JOIN STUT003 C ON A.STNO = C.STNO ");
		sql.append("LEFT JOIN STUT002 D ON C.IDNO = D.IDNO AND C.BIRTHDATE = D.BIRTHDATE ");
		sql.append("LEFT JOIN SYST001 E ON A.REFUND_STATUS = E.CODE AND E.KIND = 'REFUND_STATUS' ");
		//sql.append("JOIN SYST001 F ON A.STCARD_STATUS = F.CODE AND F.KIND = 'STCARD_STATUS' ");
		sql.append("LEFT JOIN SYST001 G ON C.STTYPE = G.CODE AND G.KIND = 'STTYPE' ");
		sql.append("LEFT JOIN EXAT054 H ON H.CHKLIST_NO = A.CHKLIST_NO AND H.IDNO= A.RECEIVER_IDNO ");
		sql.append("WHERE ");

		sql.append("A.ASYS = '").append(ASYS).append("' ");
		//sql.append(" AND PRT_DATE IS NULL ");
		// == 查詢條件 ST ==  /
		if(!Utility.checkNull(requestMap.get("AYEAR"), "").equals(""))
			sql.append("AND A.AYEAR	=	'" + Utility.dbStr(requestMap.get("AYEAR"))+ "' ");
		if(!Utility.checkNull(requestMap.get("SMS"), "").equals(""))
			sql.append("AND A.SMS	=	'" + Utility.dbStr(requestMap.get("SMS"))+ "' ");
		if(!Utility.checkNull(requestMap.get("FACTOR_CODE"), "").equals(""))
			sql.append("AND A.FACTOR_CODE	=	'" + Utility.dbStr(requestMap.get("FACTOR_CODE"))+ "' ");
		if(!Utility.checkNull(requestMap.get("STNO"), "").equals(""))
			sql.append("AND A.STNO	=	'" + Utility.dbStr(requestMap.get("STNO"))+ "' ");
		//取消列印日期為空的查詢條件 2008/08/20 by barry
		// if(Utility.checkNull(requestMap.get("FACTOR_CODE"), "").equals("")){
			// sql.append("AND PRT_DATE IS NULL");
        // }
		//新增依印領清冊編號查詢的條件  2008/08/20 by barry
		if(!Utility.checkNull(requestMap.get("CHKLIST_NO"), "").equals(""))
			sql.append("AND A.CHKLIST_NO	=	'" + Utility.dbStr(requestMap.get("CHKLIST_NO"))+ "' ");
		//新增依交付狀態為條件來查詢("Y" 已交付；"N" 未交付)  2008/08/20 by barry
		if(Utility.checkNull(requestMap.get("DELIVERY_STATUS"), "").equals("Y")){
			sql.append("AND A.CHKLIST_NO IS NOT NULL");
        }else{
			sql.append("AND A.CHKLIST_NO IS NULL ");
        }
		//印領清冊列印日期
       if(!Utility.checkNull(requestMap.get("PRT_DATE_S"),"").equals("") && !Utility.checkNull(requestMap.get("PRT_DATE_E"),"").equals("")) { 
        	sql.append(" AND A.PRT_DATE BETWEEN '" + Utility.dbStr(requestMap.get("PRT_DATE_S")) + "' AND '" + Utility.dbStr(requestMap.get("PRT_DATE_E")) + "' ");
        }
        //申請日期
       if(!Utility.checkNull(requestMap.get("APP_DATE_S"),"").equals("") && !Utility.checkNull(requestMap.get("APP_DATE_E"),"").equals("")) {
            sql.append(" AND A.APP_DATE BETWEEN '" + Utility.dbStr(requestMap.get("APP_DATE_S")) + "' AND '" + Utility.dbStr(requestMap.get("APP_DATE_E")) + "' ");
        }
		// == 查詢條件 ED ==  /

		sql.append(" ORDER BY C.CENTER_CODE,A.ASYS, A.AYEAR, A.SMS, A.STNO");
       //rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
       return sql.toString();
   }

     /**
    *
    * @param ht 條件值
    * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
    *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
    *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
    * @throws Exception
    */
   public String stu211m(Hashtable requestMap) throws Exception {
       if(requestMap == null) {
           requestMap = new Hashtable();
       }

       if(sql.length() > 0) {
           sql.delete(0, sql.length());
       }
	   //SQL語法 STU101M和STU211M應相同(若有變動應同步調整stu101m_1)    2008/08/26 by barry
       	sql.append("SELECT A.ASYS, A.AYEAR,A.SMS,A.FACTOR_CODE,A.CENTER_CODE, A.ACNT_MK, ");
		sql.append("(SELECT B.CENTER_ABBRNAME FROM SYST002 B WHERE B.CENTER_CODE=A.CENTER_CODE) CENTER_CODE_DESC, ");
		sql.append("D.NAME,A.STNO,LAB_FEE,CRD_MISC_FEE,MAG_FEE,TOT_AMT,E.CODE AS REFUND_STATUS,E.CODE_NAME AS REFUND_STATUS_DESC,G.CODE_NAME AS STTYPE_DESC,APP_DATE, ");
		sql.append("A.PRT_DATE, A.CHKLIST_NO, H.LOCK_MK ");
		sql.append("FROM STUT007 A ");
		sql.append("LEFT JOIN STUT003 C ON A.STNO = C.STNO ");
		sql.append("LEFT JOIN STUT002 D ON C.IDNO = D.IDNO AND C.BIRTHDATE = D.BIRTHDATE ");
		sql.append("LEFT JOIN SYST001 E ON A.REFUND_STATUS = E.CODE AND E.KIND = 'REFUND_STATUS' ");
		sql.append("LEFT JOIN SYST001 G ON C.STTYPE = G.CODE AND G.KIND = 'STTYPE' ");
		sql.append("LEFT JOIN EXAT054 H ON H.CHKLIST_NO = A.CHKLIST_NO AND H.IDNO= A.RECEIVER_IDNO ");
		sql.append("WHERE 1=1");

		// == 查詢條件 ST ==  /
		sql.append("AND A.CHKLIST_NO IS NOT NULL ");
		sql.append("AND A.AYEAR	=	'" + Utility.dbStr(requestMap.get("AYEAR"))+ "' ");
		sql.append("AND A.SMS	=	'" + Utility.dbStr(requestMap.get("SMS"))+ "' ");

		if(!Utility.checkNull(requestMap.get("CHKLIST_NO"), "").equals(""))
			sql.append("AND A.CHKLIST_NO	=	'" + Utility.dbStr(requestMap.get("CHKLIST_NO"))+ "' ");
		//新增依交付狀態為條件來查詢("Y" 已交付；"N" 未交付)  2008/08/20 by barry
		if(!Utility.checkNull(requestMap.get("AUDIT_STATUS"), "").equals("")){
			if(Utility.checkNull(requestMap.get("AUDIT_STATUS"), "").equals("Y"))
			{
				sql.append("AND TRIM(A.ACNT_MK) IS NOT NULL ");
			}else{
				sql.append("AND TRIM(A.ACNT_MK) IS NULL ");
			}
        }
		// == 查詢條件 ED ==  /

		sql.append(" ORDER BY A.ASYS, A.AYEAR, A.SMS, A.STNO");
       //rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
       return sql.toString();
   }



   /**
     *
     * @param ht 條件值
     * @return 回傳 Vector 物件，內容為 Hashtable 的集合，<br>
     *         每一個 Hashtable 其 KEY 為欄位名稱，KEY 的值為欄位的值<br>
     *         若該欄位有中文名稱，則其 KEY 請加上 _NAME, EX: SMS 其中文欄位請設為 SMS_NAME
     * @throws Exception
     */
    public DBResult getStut007QueryEdit(Hashtable requestMap) throws Exception {
        if(requestMap == null) {
            requestMap = new Hashtable();
        }
        Vector result = new Vector();
        if(sql.length() > 0) {
            sql.delete(0, sql.length());
        }
		sql.append("SELECT A.AYEAR AS AYEAR1,A.SMS AS SMS1,A.STNO, A.APP_DATE,A.REFUND_STATUS, A.FACTOR_CODE, A.LAB_FEE, A.CRD_MISC_FEE, A.MAG_FEE, A.TOT_AMT, A.REFUND_METHOD, A.RECEIVER_NAME, A.RECEIVER_IDNO, A.RECEIVER_ADDR_ZIP, A.RECEIVER_ADDR, A.POST_NO, A.POST_ACNT, A.BANK_CODE, A.BANK_ACNT, A.RMK, A.ROWSTAMP,B.CODE_NAME AS CENTER_CODE_DESC,D.NAME,E.CODE_NAME AS STTYPE_DESC,A.CENTER_CODE,D.IDNO,D.CRRSADDR,D.CRRSADDR_ZIP ");
		sql.append("FROM STUT007 A ");
		sql.append("JOIN SYST001 B ON A.CENTER_CODE = B.CODE AND B.KIND = 'CENTER_CODE' ");
		sql.append("JOIN STUT003 C ON A.STNO = C.STNO ");
		sql.append("JOIN STUT002 D ON C.IDNO = D.IDNO AND C.BIRTHDATE = D.BIRTHDATE ");
		sql.append("JOIN SYST001 E ON C.STTYPE = E.CODE AND E.KIND = 'STTYPE' ");
		sql.append("WHERE 1=1 ");
		sql.append(" AND A.ASYS = '").append(Utility.dbStr(requestMap.get("ASYS"))).append("'");
		sql.append(" AND A.AYEAR = '").append(Utility.dbStr(requestMap.get("AYEAR"))).append("'");
		sql.append(" AND A.SMS = '").append(Utility.dbStr(requestMap.get("SMS"))).append("'");
		sql.append(" AND A.STNO = '").append(Utility.dbStr(requestMap.get("STNO"))).append("'");


        if(!orderBy.equals("")) {
            String[] orderByArray = orderBy.split(",");
            orderBy = "";
            for(int i = 0; i < orderByArray.length; i++) {
                orderByArray[i] = "S07." + orderByArray[i].trim();

                if(i == 0) {
                    orderBy += "ORDER BY ";
                } else {
                    orderBy += ", ";
                }
                orderBy += orderByArray[i].trim();
            }
            sql.append(orderBy.toUpperCase());
            orderBy = "";
        }

        DBResult rs = null;
//        try {
//            if(pageQuery) {
//                // 依分頁取出資料
//                rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
//            } else {
//                // 取出所有資料
//                rs = dbmanager.getSimpleResultSet(conn);
//                rs.open();
//                rs.executeQuery(sql.toString());
//            }
//            Hashtable rowHt = null;
//            while (rs.next()) {
//                rowHt = new Hashtable();
//                /** 將欄位抄一份過去 */
//                for (int i = 1; i <= rs.getColumnCount(); i++)
//                    rowHt.put(rs.getColumnName(i), rs.getString(i));
//
//                result.add(rowHt);
//            }
//
//        } catch (Exception e) {
//            throw e;
//        } finally {
//            if(rs != null) {
//                rs.close();
//            }
//        }

//        rs = Page.getPageResultSet(dbmanager, conn, sql.toString(), pageNo, pageSize);
        rs = dbmanager.getSimpleResultSet(conn);
        rs.open();
        rs.executeQuery(sql.toString());
        return rs;
    }





}
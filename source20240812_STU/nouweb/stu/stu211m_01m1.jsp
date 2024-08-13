<%/*
----------------------------------------------------------------------------------
File Name		: stu211m_01m1.jsp
Author			: barry
Description		: �h�ǰh�O�f�� - �B�z�޿譶��
Modification Log	:

Vers		Date       	By            	Notes
--------------	--------------	--------------	----------------------------------
0.0.1		097/08/07	barry    	Code Generate Create
----------------------------------------------------------------------------------
*/%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="MS950"%>
<%@ include file="/utility/header.jsp"%>
<%@ include file="/utility/modulepageinit.jsp"%>
<%@page import="com.nou.sgu.dao.*"%>
<%@page import="com.nou.stu.dao.*"%>
<%@page import="com.nou.reg.dao.*"%>
<%@page import="com.nou.exa.dao.EXAT054DAO"%>
<%@ page import="com.nou.exa.EXAEXPENSE"%>
<%@ page import="com.nou.tra.bo.TRAADDINFO"%>
<%@ page import="com.nou.webService.*"%>
<%!
/** �B�z�d�� Grid ��� */
public void doQuery(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	Connection	conn	=	null;
	DBResult	rs	=	null;

	try
	{
		conn	=	dbManager.getConnection(AUTCONNECT.mapConnect("STU", session));

		int		pageNo		=	Integer.parseInt(Utility.checkNull(requestMap.get("pageNo"), "1"));
		int		pageSize	=	Integer.parseInt(Utility.checkNull(requestMap.get("pageSize"), "10"));
		StringBuffer	sql		=	new StringBuffer();
		STUT007GATEWAY getway = new STUT007GATEWAY(dbManager, conn, pageNo, pageSize);	
		String s1=getway.stu211m(requestMap);
		rs	=	Page.getPageResultSet(dbManager, conn, s1, pageNo, pageSize);
		out.println(DataToJson.rsToJson (Page.getTotalRowCount(), rs));
	}
	catch (Exception ex)
	{
		throw ex;
	}
	finally
	{
		if (rs != null)
			rs.close();
		if (conn != null)
			conn.close();

		rs	=	null;
		conn	=	null;
	}
}

/** �R����� */
public void doDelete(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	try
	{
		Connection	conn		=	dbManager.getConnection(AUTCONNECT.mapConnect("NOU", session));

		/** �R������ */
		StringBuffer	conditionBuff	=	new StringBuffer();

		String[]	CHKLIST_NO	=	Utility.split(requestMap.get("CHKLIST_NO").toString(), ",");

		for (int i = 0; i < CHKLIST_NO.length; i++)
		{
			if (i > 0)
				conditionBuff.append (" OR ");

			conditionBuff.append
			(
				"(" +
				"	CHKLIST_NO	=	'" + Utility.dbStr(CHKLIST_NO[i])+ "' " +
				")"
			);
		}

		/** �B�z�R���ʧ@ */
		SGUT016DAO	SGUT016	=	new SGUT016DAO(dbManager, conn, requestMap, session);
		SGUT016.delete(conditionBuff.toString());

		/** Commit Transaction */
		dbManager.commit();

		out.println(DataToJson.successJson());
	}
	catch (Exception ex)
	{
		/** Rollback Transaction */
		dbManager.rollback();

		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}

private void doPrint(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	
}

/** ��I��� */
public void doDelivery(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn        =    dbManager.getConnection(AUTCONNECT.mapConnect("REG", session));

        /** ��s���� */
        StringBuffer    conditionBuff    =    new StringBuffer();

        String[]    SCHOLAR_TYPE_CODE        =    Utility.split(requestMap.get("SCHOLAR_TYPE_CODE").toString(), ",");
        String[]    AYEAR        =    Utility.split(requestMap.get("AYEAR").toString(), ",");
        String[]    SMS        =    Utility.split(requestMap.get("SMS").toString(), ",");
        String[]    ASYS        =    Utility.split(requestMap.get("ASYS").toString(), ",");
		String[]    STNO        =    Utility.split(requestMap.get("STNO").toString(), ",");
		String[]    PAY_MANNER        =    Utility.split(requestMap.get("PAY_MANNER").toString(), ",");
		String[]    CENTER_CODE        =    Utility.split(requestMap.get("CENTER_CODE").toString(), ",");
		String[]    IDNO        =    Utility.split(requestMap.get("IDNO").toString(), ",");
		String[]    SCHOLAR_AMT        =    Utility.split(requestMap.get("SCHOLAR_AMT").toString(), ",");
		int size1 = 0;
		int size2 = 0;
		String CHKLIST_NO = "";
		StringBuffer sql    =    null;
		Vector v1 = null;
        for (int i = 0; i < AYEAR.length; i++)
        {
            if (i > 0)
                conditionBuff.append (" OR ");

            conditionBuff.append
            (
                "(" +
                "    SCHOLAR_TYPE_CODE        =    '" + Utility.dbStr(SCHOLAR_TYPE_CODE[i]) + "' AND " +
                "    AYEAR        =    '" + Utility.dbStr(AYEAR[i]) + "' AND " +
                "    SMS        =    '" + Utility.dbStr(SMS[i]) + "' AND " +
				"    ASYS        =    '" + Utility.dbStr(ASYS[i]) + "' AND " +
                "    STNO        =    '" + Utility.dbStr(STNO[i]) + "' " +
                ")"
            );
        }
		EXAEXPENSE EXA = null;
		TRAADDINFO TRA = null;
		EXA.setCOUNT_TYPE("4");
		if(EXA.execute() == 1)
		{
			CHKLIST_NO = EXA.getCHKLIST_NO();
			/** �B�z��I�ʧ@ */
			
			
			for (int i = 0; i < AYEAR.length; i++)
			{
				sql    =    new StringBuffer();
				sql.append(
						"SELECT b.NAME, b.ALIAS, b.ENG_NAME, b.BIRTHDATE, b.SEX, b.DMSTADDR_ZIP, " +
						"b.DMSTADDR, b.CRRSADDR_ZIP, b.CRRSADDR, b.AREACODE_HOME, b.TEL_HOME, " +
						"b.MOBILE, b.FAX_AREACODE, b.FAX_TEL, b.EMAIL, b.POST_NO, b.POST_ACNT, " +
						"b.BANK_CODE, b.BANK_ACNT FROM STUT003 a " +
						"JOIN STUT002 b ON a.IDNO=b.IDNO and a.BIRTHDATE=b.BIRTHDATE " +
						"WHERE a.STNO = '" + STNO[i] + "' ");
				v1 = getDATA(dbManager, conn, sql);
				if(v1.size() != 0)
				{
					Hashtable tmpHt = (Hashtable)v1.get(0);
					TRA = new TRAADDINFO(dbManager, session);
					TRA.setIDNO(IDNO[i]);
					TRA.setNAME(Utility.nullToSpace(tmpHt.get("NAME")));
					TRA.setALIAS(Utility.nullToSpace(tmpHt.get("ALIAS")));
					TRA.setENG_NAME(Utility.nullToSpace(tmpHt.get("ENG_NAME")));
					TRA.setBIRTHDATE(Utility.nullToSpace(tmpHt.get("BIRTHDATE")));
					TRA.setSEX(Utility.nullToSpace(tmpHt.get("SEX")));
					TRA.setDMSTADDR_ZIP(Utility.nullToSpace(tmpHt.get("DMSTADDR_ZIP")));
					TRA.setDMSTADDR(Utility.nullToSpace(tmpHt.get("DMSTADDR")));
					TRA.setCRRSADDR_ZIP(Utility.nullToSpace(tmpHt.get("CRRSADDR_ZIP")));
					TRA.setCRRSADDR(Utility.nullToSpace(tmpHt.get("CRRSADDR")));
					TRA.setAREACODE_HOME(Utility.nullToSpace(tmpHt.get("AREACODE_HOME")));
					TRA.setTEL_HOME(Utility.nullToSpace(tmpHt.get("TEL_HOME")));
					TRA.setMOBILE(Utility.nullToSpace(tmpHt.get("MOBILE")));
					TRA.setFAX_AREACODE(Utility.nullToSpace(tmpHt.get("FAX_AREACODE")));
					TRA.setFAX_TEL(Utility.nullToSpace(tmpHt.get("FAX_TEL")));
					TRA.setEMAIL(Utility.nullToSpace(tmpHt.get("EMAIL")));
					TRA.setPOST_NO(Utility.nullToSpace(tmpHt.get("POST_NO")));
					TRA.setPOST_ACNT(Utility.nullToSpace(tmpHt.get("POST_ACNT")));
					TRA.setBANK_CODE(Utility.nullToSpace(tmpHt.get("BANK_CODE")));
					TRA.setBANK_ACNT(Utility.nullToSpace(tmpHt.get("BANK_ACNT")));
					TRA.setPRO_CODE(Utility.nullToSpace(tmpHt.get("SGUT043M")));
					if(TRA.execute() == 1)
						size2 += 1;
				}
			}
			
			if(AYEAR.length == size2)
			{
				/** �פJ�Юv����ɧ��� ��COMMIT */
			    dbManager.commit();
				for (int i = 0; i < AYEAR.length; i++)
				{
					EXA = new EXAEXPENSE(dbManager);
					EXA.setAYEAR(AYEAR[i]);
					EXA.setSMS(SMS[i]);
					EXA.setDEP_CODE(CENTER_CODE[i]);
					EXA.setEXPENSE_TYPE_CODE("W09");
					if(SCHOLAR_TYPE_CODE[i].equals("01"))
						EXA.setITEM_NAME("���Z�u�q�ǥͼ��Ǫ�");
					else if(SCHOLAR_TYPE_CODE[i].equals("02"))
						EXA.setITEM_NAME("�S���N�ǥͼ��Ǫ�");
					else if(SCHOLAR_TYPE_CODE[i].equals("03"))
						EXA.setITEM_NAME("���߻�ê�ǥͼ��B�U�Ǫ�");
					else if(SCHOLAR_TYPE_CODE[i].equals("04"))
						EXA.setITEM_NAME("�����ǥͼ��Ǫ�");
					EXA.setPAYABLE_AMT(SCHOLAR_AMT[i]);
					EXA.setCHKLIST_NO(CHKLIST_NO);
					EXA.setIDNO(IDNO[i]);
					EXA.setCOUNT_TYPE("6");
					EXA.setPAY_MANNER(PAY_MANNER[i]);
					EXA.setUPD_USER_ID((String)session.getAttribute("USER_ID"));
					EXA.setUNDERTAKER_IDNO((String)session.getAttribute("USER_IDNO"));
					if(EXA.execute()==1)
						size1 += 1;
				}
				if(AYEAR.length == size1)
				{
					//�g�J�L��M�U�s��
			        SGUT003DAO    SGUT003    =    new SGUT003DAO(dbManager, conn, requestMap, session);
					SGUT003.setCHKLIST_NO(CHKLIST_NO);
			        SGUT003.update(conditionBuff.toString());
					/** Commit Transaction */
			        dbManager.commit();
			        out.println(DataToJson.successJson());
				}else{
					out.println(DataToJson.faileJson("��I����!!"));
					dbManager.rollback();
				}
			}else{
				out.println(DataToJson.faileJson("��J�Юv��ƥ���!!"));
				dbManager.rollback();
			}
			
		}else{
			out.println(DataToJson.faileJson("���L��M�U�s������!!"));
			dbManager.rollback();
		}
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();

        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

/** �h��-�D�p�f�ֳq�L�ζצܨȩ� */
public void doRefuse(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn        =    dbManager.getConnection(AUTCONNECT.mapConnect("REG", session));
		
		/**�d�߬O�_�i�H�h��*/
		EXAT054DAO exat054 = new EXAT054DAO(dbManager, conn);
		exat054.setResultColumn("LOCK_MK");
		exat054.setCHKLIST_NO(Utility.dbStr(requestMap.get("CHKLIST_NO")));
		DBResult rs = exat054.query();
		
		if(rs.next()){
			if(rs.getString("LOCK_MK").equals("2")){
				out.println(DataToJson.faileJson("�ӦL��M�U�s���w�צܨȩ�,�p�ݰh��Цܨȩ��t�ΰh��!!"));
				return;
			}
		}else{
			out.println(DataToJson.faileJson("�d�L�ӦL��M�U�s�����!!"));
			return;		
		}				
			
		// �^�_�аȳB��I�᪺���
	    STUT007DAO stut007 = new STUT007DAO(dbManager, conn);
	    stut007.setResultColumn("AYEAR,SMS,STNO,ACNT_MK");
	    stut007.setCHKLIST_NO(Utility.dbStr(requestMap.get("CHKLIST_NO")));
	    rs = stut007.query();
	    
	    while(rs.next()){
	    	// �p�����D�p�Ǽf�ֳq�L��,�h���i���s���O
	    	if(!rs.getString("ACNT_MK").equals("Y"))
	    		continue;
	    		
		    // ���y���
		    EXAT054DAO EE = new EXAT054DAO(dbManager, conn);
		    exat054.setREMIT_DATE("");
		    exat054.setLOCK_MK("1");
		    exat054.update("CHKLIST_NO='" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "'");
					
		}
		rs.close();
		
		// �M�ťDtable���L��M�U�s��
		STUT007DAO SS = new STUT007DAO(dbManager, conn, session.getAttribute("USER_ID").toString());
		SS.setACNT_MK("");
	    SS.update("CHKLIST_NO = '" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "' ");

		dbManager.commit();
		
		out.println(DataToJson.successJson("�h�󦨥\!!"));
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();
        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

/** �צܨȩ��t�� */
public void doAssota(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	DBResult rs = null;
    try
    {
        Connection    conn        =    dbManager.getConnection(AUTCONNECT.mapConnect("REG", session));

		if(Utility.dbStr(requestMap.get("CHKLIST_NO")).equals("")){
			out.println(DataToJson.faileJson("�L��M�U�s�����i����"));
			return;
		}
				
		/**�d�߿�J���L��M�U�s���O�_�s�bSTUT007*/
		StringBuffer    sql    =    new StringBuffer();
		sql.append("SELECT COUNT(1) NUM FROM STUT007 WHERE CHKLIST_NO = '" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "' AND ACNT_MK<>'Y' ");
		Vector v1 = getDATA(dbManager, conn, sql);
		if(v1.size()!=0){
			Hashtable tmpHt = (Hashtable)v1.get(0);

			if(Integer.parseInt(tmpHt.get("NUM").toString()) > 0){
				out.println(DataToJson.faileJson("��Ʃ|�������f�ֳq�L,���o�i��ץX"));
				return;
			}
		}
		
		//�b���s�N�򥻸�ƻP�ȩ��P�B
		rs = this.getStuData(dbManager, conn, Utility.dbStr(requestMap.get("CHKLIST_NO")));
		while(rs.next()){
			TRAADDINFO TRA = new TRAADDINFO(dbManager, session);
			TRA.setIDNO(rs.getString("IDNO"));
			TRA.setNAME(rs.getString("NAME"));
			TRA.setALIAS(rs.getString("ALIAS"));
			TRA.setENG_NAME(rs.getString("ENG_NAME"));
			TRA.setBIRTHDATE(rs.getString("BIRTHDATE"));
			TRA.setSEX(rs.getString("IDNO").length()==10&&rs.getString("IDNO").substring(1,2).equals("1")?"1":"2");
			TRA.setDMSTADDR_ZIP(rs.getString("DMSTADDR_ZIP"));
			TRA.setDMSTADDR(rs.getString("DMSTADDR"));
			TRA.setCRRSADDR_ZIP(rs.getString("CRRSADDR_ZIP"));
			TRA.setCRRSADDR(rs.getString("CRRSADDR"));
			TRA.setAREACODE_HOME(rs.getString("AREACODE_HOME"));
			TRA.setTEL_HOME(rs.getString("TEL_HOME"));
			TRA.setMOBILE(rs.getString("MOBILE"));
			TRA.setFAX_AREACODE(rs.getString("FAX_AREACODE"));
			TRA.setFAX_TEL(rs.getString("FAX_TEL"));
			TRA.setEMAIL(rs.getString("EMAIL"));
			TRA.setPOST_NO(rs.getString("POST_NO"));
			TRA.setPOST_ACNT(rs.getString("POST_ACNT"));
			TRA.setBANK_CODE(rs.getString("BANK_CODE"));
			TRA.setBANK_ACNT(rs.getString("BANK_ACNT"));
			TRA.setPRO_CODE("STU211M");
			
			if(TRA.execute()!=TRA.SUCCESS){					
				out.println(DataToJson.faileJson("�ǥ�:"+rs.getString("NAME")+"(�Ǹ�:"+rs.getString("STNO")+")�s�W�򥻸�Ʀܨȩ��ɵo�Ϳ��~:"+TRA.getAllError()));
				return;
			}					
		}
		
		if(rs==null){
			out.println(DataToJson.faileJson("�L��ƥi�צܨȩ�"));
			return;			
		}else
			rs.close();
		dbManager.commit();
		
		/**�d�߬O�_�w�צܨȩ��t��*/
		EXAT054DAO exat054 = new EXAT054DAO(dbManager, conn);
		exat054.setResultColumn("count(1) AS IS_SEND");
		exat054.setCHKLIST_NO(Utility.dbStr(requestMap.get("CHKLIST_NO")));
		exat054.setLOCK_MK("2");
		rs = exat054.query();
		
		if(rs.next()&&!rs.getString("IS_SEND").equals("0")){
			out.println(DataToJson.faileJson("��Ƥw�צܨȩ�,���o�i��ץX"));
			return;
		}		
		
		/** �}�l�צܨȩ� */
		Hashtable exportData = new Hashtable();
		exportData.put("CHKLIST_NO",Utility.dbStr(requestMap.get("CHKLIST_NO")));
		exportData.put("USER_ID",(String)session.getAttribute("USER_ID"));				
		WebServiceFile webServiceFile = new WebServiceFile(dbManager, conn);
				
		String errorMsg = webServiceFile.EXAF001(exportData);	
		if(!errorMsg.equals("")){				
			out.println(DataToJson.faileJson("�צܨȩ�����:�P�ȩ��t�γs�u����"+errorMsg));
			return;
		}
			
		out.println(DataToJson.successJson("�צܨȩ����\"));		
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();
        out.println(DataToJson.faileJson("�צܨȩ�����"));
        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

// ���o�ӦL��M�U���ǥ͸��
private DBResult getStuData(DBManager dbManager, Connection conn, String chklistNo){
	DBResult result = null;
	
	try{
		String getStuData =
			"SELECT "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_IDNO,'B4',c.RECEIVER_IDNO,a.IDNO) AS IDNO, "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_NAME,'B4',c.RECEIVER_NAME,b.NAME) AS NAME, "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_ADDR_ZIP,'B4',c.RECEIVER_ADDR_ZIP,b.DMSTADDR_ZIP) AS DMSTADDR_ZIP, "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_ADDR_ZIP,'B4',c.RECEIVER_ADDR_ZIP,b.DMSTADDR_ZIP) AS CRRSADDR_ZIP, "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_ADDR,'B4',c.RECEIVER_ADDR,b.DMSTADDR) AS DMSTADDR, "+
				"decode(REFUND_METHOD,'A4',c.RECEIVER_ADDR,'B4',c.RECEIVER_ADDR,b.CRRSADDR) AS CRRSADDR, "+
				"decode(REFUND_METHOD,'A4','','B4','',b.ALIAS) AS ALIAS, "+
				"decode(REFUND_METHOD,'A4','','B4','',b.ENG_NAME) AS ENG_NAME, "+
				"b.BIRTHDATE,a.STNO, "+
				"decode(REFUND_METHOD,'A4','','B4','',b.SEX) AS SEX, "+
				"a.CENTER_CODE, b.AREACODE_HOME, b.TEL_HOME,b.MOBILE, b.FAX_AREACODE, b.FAX_TEL, b.EMAIL,"+
				"c.POST_NO, c.POST_ACNT,c.BANK_CODE, c.BANK_ACNT, c.REFUND_METHOD, c.TOT_AMT "+
			"FROM STUT007 c "+
				"JOIN STUT003 a ON a.STNO=c.STNO " +
				"JOIN STUT002 b ON a.IDNO=b.IDNO and a.BIRTHDATE=b.BIRTHDATE " +
			"WHERE c.CHKLIST_NO = '" + chklistNo + "'  ";
			
		STUT007DAO stut007 = new STUT007DAO(dbManager, conn);
		result = stut007.query(getStuData);
	}catch(Exception e){
		e.printStackTrace();	
	}finally{
	
	}
	
	return result;
}

/** �צܨȩ��t�� */
public void doAssota_Old(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
    try
    {
        Connection    conn        =    dbManager.getConnection(AUTCONNECT.mapConnect("REG", session));
		
		String YN = "N";	//�w�]���i�צܨȩ��t��
		String YN2 = "N";	//�w�]���i�צܨȩ��t��
		int num = 0;		//�w�]�ӦL��M�U�u��0�����
		int num2 = -1;		//�w�]�ӦL��M�U�w�f�d�q�L��-1�����
		int EXA_STATUS = -1;		//�w�]���楢��
		int updateCount = 0;		//�w�]��s����
		Vector v1 = null;				
		/**�d�߿�J���L��M�U�s���O�_�s�bSTUT007*/
		StringBuffer    sql    =    new StringBuffer();
		sql.append("SELECT COUNT(1) NUM FROM STUT007 WHERE CHKLIST_NO = '" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "' ");
		v1 = getDATA(dbManager, conn, sql);
		if(v1.size()!=0)
		{
			Hashtable tmpHt = (Hashtable)v1.get(0);
			num = Integer.parseInt(tmpHt.get("NUM").toString());
		}
		if(num != 0)
		{
			sql    =    new StringBuffer();
			sql.append("SELECT COUNT(1) NUM FROM STUT007 WHERE CHKLIST_NO = '" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "' AND ACNT_MK='Y' ");
			v1 = getDATA(dbManager, conn, sql);
			if(v1.size()!=0)
			{
				Hashtable tmpHt = (Hashtable)v1.get(0);
				num2 = Integer.parseInt(tmpHt.get("NUM").toString());
			}
		}
		
		// north 2008.12.18  �Ȯ�(�Q�f�����O�Ȯ�)�令�o��,����������I��,�N�����U�~�����,����ܸ�ƥ�������I,���o�ץX
		if(num != num2){
			out.println(DataToJson.faileJson("��Ʃ|�������f�ֳq�L,���o�i��ץX"));
			return;
		}
		
		String exportResult = "XXX";
		if(num == num2)
		{
			/**�d�߬O�_�i�H�צܨȩ��t��*/
			sql    =    new StringBuffer();
			sql.append("SELECT COUNT(1) NUM FROM EXAT054 WHERE CHKLIST_NO = '" + Utility.dbStr(requestMap.get("CHKLIST_NO")) + "' AND LOCK_MK = '2' ");
			v1 = getDATA(dbManager, conn, sql);
			if(v1.size()!=0)
			{
				Hashtable tmpHt = (Hashtable)v1.get(0);
				if(tmpHt.get("NUM").toString().equals("0"))
					YN = "Y";
			}
			//�i�צܨȩ��t�� ����Ƶ{���i��צܨȩ��t�γB�z
			String errorMsg="";
			if(YN.equals("Y"))
			{
				Hashtable exportData = new Hashtable();
				exportData.put("CHKLIST_NO",Utility.dbStr(requestMap.get("CHKLIST_NO")));
				exportData.put("USER_ID",(String)session.getAttribute("USER_ID"));				
				WebServiceFile webServiceFile = new WebServiceFile(dbManager, conn);
				
				errorMsg = webServiceFile.EXAF001(exportData);	
				if(errorMsg.equals("")){
					//out.println(DataToJson.successJson("�צܨȩ����\"));					
					EXA_STATUS = 0;
				}else{
					out.println(DataToJson.faileJson("�צܨȩ�����:�P�ȩ��t�γs�u����"));
					return;
				}
			}
		}
		
	    if(num == 0)
		{
			out.println(DataToJson.faileJson("�ҿ�J���L��M�U�s���d�L���!!"));
			/** ���ѫhrollback*/
			dbManager.rollback();
		}
		else if(!YN.equals("Y"))
		{
			String message1 = "";
			if(!YN.equals("Y"))
				message1 = "�w�צܨȩ��t�ΡA���i���榹�\��";
			out.println(DataToJson.faileJson(message1));
			/** ���ѫhrollback*/
			dbManager.rollback();
		}
		else if(EXA_STATUS == 0 && exportResult.equals(""))
		{
			out.println(DataToJson.successJson("�צܨȩ��t�Φ��\!!"));
			/** ���\�hcommit*/
			dbManager.commit();
		}else{
			out.println(DataToJson.faileJson("�צܨȩ��t�Υ���!!"));
			/** ���ѫhrollback*/
			dbManager.rollback();
		}
    }
    catch (Exception ex)
    {
        /** Rollback Transaction */
        dbManager.rollback();
        throw ex;
    }
    finally
    {
        dbManager.close();
    }
}

/** �f�d�q�L */
public void doPass(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	try
	{
		Connection	conn		=	dbManager.getConnection(AUTCONNECT.mapConnect("NOU", session));

		/** ��s���� */
		StringBuffer	conditionBuff	=	new StringBuffer();

		String[]	ASYS	=	Utility.split(requestMap.get("ASYS").toString(), ",");
		String[]	AYEAR	=	Utility.split(requestMap.get("AYEAR").toString(), ",");
		String[]	SMS	=	Utility.split(requestMap.get("SMS").toString(), ",");
		String[]	STNO	=	Utility.split(requestMap.get("STNO").toString(), ",");

		for (int i = 0; i < ASYS.length; i++)
		{
			if (i > 0)
				conditionBuff.append (" OR ");

			conditionBuff.append
			(
				"(" +
                "    ASYS        =    '" + Utility.dbStr(ASYS[i]) + "' AND " +
				"    AYEAR        =    '" + Utility.dbStr(AYEAR[i]) + "' AND " +
                "    SMS        =    '" + Utility.dbStr(SMS[i]) + "' AND " +
                "    STNO        =    '" + Utility.dbStr(STNO[i]) + "' " +
				")"
			);
		}

		/** �B�z��s�ʧ@ */
		STUT007DAO	STUT007	=	new STUT007DAO(dbManager, conn, (String)session.getAttribute("USER_ID"));
		STUT007.setACNT_MK("Y");
		int upCount = STUT007.update(conditionBuff.toString());
		
		if(upCount == 0)
		{
			out.println(DataToJson.faileJson("������Ƥw�Q���ʹL, <br>�Э��s�d�߭ק�!!"));
		}else{
			/** Commit Transaction */
			dbManager.commit();
			out.println(DataToJson.successJson());
		}
	}
	catch (Exception ex)
	{
		/** Rollback Transaction */
		dbManager.rollback();

		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}

/** �f�d���q�L */
public void doNotPass(JspWriter out, DBManager dbManager, Hashtable requestMap, HttpSession session) throws Exception
{
	try
	{
		Connection	conn		=	dbManager.getConnection(AUTCONNECT.mapConnect("NOU", session));

		/** ��s���� */
		StringBuffer	conditionBuff	=	new StringBuffer();

		String[]	ASYS	=	Utility.split(requestMap.get("ASYS").toString(), ",");
		String[]	AYEAR	=	Utility.split(requestMap.get("AYEAR").toString(), ",");
		String[]	SMS	=	Utility.split(requestMap.get("SMS").toString(), ",");
		String[]	STNO	=	Utility.split(requestMap.get("STNO").toString(), ",");

		for (int i = 0; i < ASYS.length; i++)
		{
			if (i > 0)
				conditionBuff.append (" OR ");

			conditionBuff.append
			(
				"(" +
                "    ASYS        =    '" + Utility.dbStr(ASYS[i]) + "' AND " +
				"    AYEAR        =    '" + Utility.dbStr(AYEAR[i]) + "' AND " +
                "    SMS        =    '" + Utility.dbStr(SMS[i]) + "' AND " +
                "    STNO        =    '" + Utility.dbStr(STNO[i]) + "' " +
				")"
			);
		}

		/** �B�z��s�ʧ@ */
		STUT007DAO	STUT007	=	new STUT007DAO(dbManager, conn, (String)session.getAttribute("USER_ID"));
		STUT007.setACNT_MK("N");
		int upCount = STUT007.update(conditionBuff.toString());
		
		if(upCount == 0)
		{
			out.println(DataToJson.faileJson("������Ƥw�Q���ʹL, <br>�Э��s�d�߭ק�!!"));
		}else{
			/** Commit Transaction */
			dbManager.commit();
			out.println(DataToJson.successJson());
		}
	}
	catch (Exception ex)
	{
		/** Rollback Transaction */
		dbManager.rollback();

		throw ex;
	}
	finally
	{
		dbManager.close();
	}
}

//�d�ߩһݸ��
private Vector getDATA(DBManager dbManager, Connection conn, StringBuffer sql) throws Exception
{
	DBResult	rs	=	null;
	Vector		vt	=	null;
	Hashtable	ht	=	null;

	try
	{
		vt	=	new Vector();
		rs	=	dbManager.getSimpleResultSet(conn);
		rs.open();
		rs.executeQuery(sql.toString());
		
		while (rs.next())
		{
			ht	=	new Hashtable();
			for (int i = 1; i <= rs.getColumnCount(); i++)
                ht.put(rs.getColumnName(i), rs.getString(i));
			vt.add(ht);
		}

		return vt;
	}
	catch(Exception e)
	{
		throw e;
	}
	finally
	{
		if (rs != null)
			rs.close();
	}
}

%>
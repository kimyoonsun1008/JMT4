package com.jmt.moim.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.jmt.moim.dao.DojangDAO;
import com.jmt.moim.dto.DojangDTO;

@Service
public class DojangService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired  DojangDAO dao;

	public HashMap<String, Object> dojangList(HashMap<String, String> params, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = Integer.parseInt(params.get("cnt"));
		int page = Integer.parseInt(params.get("page"));
		logger.info("보여줄 페이지 :" + page);
		
		//검색조건
		String search = params.get("search");
		String foodname = params.get("foodname");
		String eat_speed = params.get("eat_speed");
		String job = params.get("job");
		String gender = params.get("gender");
		
		
		
		HashMap<String, Object> searchResult = new HashMap<String, Object>();
		
		searchResult.put("search", search);
		searchResult.put("foodname", foodname);
		searchResult.put("eat_speed", eat_speed);
		searchResult.put("job", job);
		searchResult.put("gender", gender);
		searchResult.put("loginId", session.getAttribute("loginId"));
		
		logger.info("확인:::"+session.getAttribute("loginId"));
		

		int allCnt = dao.allCount(searchResult);
		logger.info("allCnt : " + allCnt);
		
		int pages = allCnt % cnt > 0 ? (allCnt / cnt)+1 : (allCnt / cnt);
		logger.info("pages : " + pages);
		
		if(pages==0) {pages=1;}
		
		if(page>pages) {
			page = pages;
		}
		
		logger.info("pages : " + pages);
		map.put("pages", pages); //만들 수 있는 최대 페이지 수
		map.put("currPage", page); // 현재 페이지
		
		int offset = (page-1)*cnt; 
		logger.info("offset: " + offset);
		
		
		searchResult.put("cnt", cnt);
		searchResult.put("offset", offset);
		
		ArrayList<DojangDTO> list = dao.dojangList(searchResult);

		map.put("dojangList", list);
		
		

		return map;
	}

	public ArrayList<DojangDTO> foodname() {
		return dao.foodname();
	}

	public ModelAndView dojangDetail(String dojang_no, String loginId) {
		logger.info("도장 상세보기");
		DojangDTO dojangDetail = dao.dojangDetail(dojang_no);
		ArrayList<DojangDTO> dojangGreview = dao.dojangGreview(dojang_no);
		
		//가입신청 관리
		DojangDTO applyStatus = dao.applyStatus(loginId,dojang_no);
		logger.info("data:::"+loginId+","+dojang_no);
		//logger.info("상태"+applyStatus.getStatus());
		
		
		
		String leader = dao.reported(dojang_no);
		logger.info("리더"+leader);
		
		ModelAndView mav = new ModelAndView();
		
		
		//"redirect:/detail.do?idx="+params.get("idx");
		
		/*
		if(leader == null || status.equals("승인")) {
			mav.setViewName("redirect:/dojangHome.do?dojang_no="+dojang_no);
		}else {
		*/
		
		//가입신청 프로필조건
		DojangDTO profileStatus = dao.profileStatus(loginId);
		
		mav.setViewName("./Dojang/dojangDetail");
		mav.addObject("dojangDetail",dojangDetail);
		mav.addObject("dojangGreview",dojangGreview);
		mav.addObject("applyStatus",applyStatus);
		mav.addObject("profileStatus",profileStatus);
		
		//}
		
		return mav;
	}

	public boolean dojangApply(String dojang_no, String loginId) {
		
		HashMap<String, Object> result=new HashMap<String, Object>();
		logger.info("확인:::"+dojang_no);
		
		int row = dao.dojangApply(dojang_no,loginId);
		
		boolean success = false;
		
		if(row >0) {
			success = true;
		}
		
		result.put("success", success);
		return success;
		
		
		
	}


	public boolean dojangReg(HashMap<String, String> params) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		
		if(dao.dojangReg(params)>0) {
			success = true;
		}
		
		result.put("success", success);
		return success;
	}

	public boolean dojangReport(HashMap<String, String> params) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		boolean success = false;
		
		if(dao.dojangReport(params)>0) {
			success = true;
		}
		
		result.put("success", success);
		return success;
	
	}

	public String reported(String dojang_no) {
		return dao.reported(dojang_no);
	}



	public ArrayList<DojangDTO> dojangHome(String dojang_no) {
		return dao.dojangHome(dojang_no);
	}

	public ArrayList<DojangDTO> dojangHomeMember(String dojang_no) {
		
		return dao.dojangHomeMember(dojang_no);
	}

	

	


}

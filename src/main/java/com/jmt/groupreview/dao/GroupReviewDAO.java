package com.jmt.groupreview.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.jmt.groupreview.dto.GroupReviewDTO;

public interface GroupReviewDAO {

	//ArrayList<GroupReviewDTO> groupReviewList();

	//ArrayList<GroupReviewDTO> reviewSearch(String keyword);

	ArrayList<GroupReviewDTO> groupReviewList(HashMap<String, Object> searchResult);

	int allCount(HashMap<String, Object> searchResult);

	ArrayList<GroupReviewDTO> sortNumChange(String sortNum, int cnt, int offset);

	GroupReviewDTO groupReviewDetail(String groupReview_no);

	ArrayList<GroupReviewDTO> groupSearchList(String groupSortChange, String loginId);

	//void groupReviewRegister(GroupReviewDTO dto, String loginId);

	void grFileWrite(String newFileName, String string, int class_no, int idx);

	void groupReviewRegister(GroupReviewDTO dto);

	ArrayList<GroupReviewDTO> grPhotoList(String idx);

}

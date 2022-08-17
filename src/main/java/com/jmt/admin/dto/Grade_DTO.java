package com.jmt.admin.dto;
import org.apache.ibatis.type.Alias;

@Alias("grade")
public class Grade_DTO {

	private int grade_no;
	private String grade_name;
	private String grade_color;
	private String grade_post;
	private int grade_comment;
	
	
	public int getGrade_no() {
		return grade_no;
	}
	public void setGrade_no(int grade_no) {
		this.grade_no = grade_no;
	}
	public String getGrade_name() {
		return grade_name;
	}
	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}
	public String getGrade_color() {
		return grade_color;
	}
	public void setGrade_color(String grade_color) {
		this.grade_color = grade_color;
	}
	public String getGrade_post() {
		return grade_post;
	}
	public void setGrade_post(String grade_post) {
		this.grade_post = grade_post;
	}
	public int getGrade_comment() {
		return grade_comment;
	}
	public void setGrade_comment(int grade_comment) {
		this.grade_comment = grade_comment;
	}
	
	
}

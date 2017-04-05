package com.suven.article.entity;

import java.util.Date;

/**
 * @Description 博客实体
 * @author fp942
 * Created by fp942 on 2017/2/25.
 *
 */
public class Blog {
	private Integer id;//博客ID
	private String title;//博客标题
	private String summary;//博客摘要
	private Date releaseDate;//博客发表日期
	private Integer clickHit;//博客点击数
	private Integer replyHit;//博客评论数
	private String content;//博客内容
	private String keyWord; //关键字，用空格隔开
	private Integer type_id;//博客类型ID
	private String author;//博客作者
	private Integer author_id;//博客ID


	private BlogType blogType; //博客类型
	private String releaseDateStr; //文章存档用,发布日期的字符串，只取年月
	private Integer blogCount; //博客数量，非博客实际属性，用于根据发布日期归档查询
	private String imagename;//博客所属用户的头像

	public Blog(Integer id, String title, String summary, Date releaseDate, Integer clickHit, Integer replyHit, String content, String keyWord, Integer type_id, String author, Integer author_id, BlogType blogType) {
		this.id = id;
		this.title = title;
		this.summary = summary;
		this.releaseDate = releaseDate;
		this.clickHit = clickHit;
		this.replyHit = replyHit;
		this.content = content;
		this.keyWord = keyWord;
		this.type_id = type_id;
		this.author = author;
		this.author_id = author_id;
		this.blogType = blogType;
	}

	public Blog(){

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public Integer getClickHit() {
		return clickHit;
	}

	public void setClickHit(Integer clickHit) {
		this.clickHit = clickHit;
	}

	public Integer getReplyHit() {
		return replyHit;
	}

	public void setReplyHit(Integer replyHit) {
		this.replyHit = replyHit;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public Integer getType_id() {
		return type_id;
	}

	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Integer getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(Integer author_id) {
		this.author_id = author_id;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public BlogType getBlogType() {
		return blogType;
	}

	public void setBlogType(BlogType blogType) {
		this.blogType = blogType;
	}

	public String getReleaseDateStr() {
		return releaseDateStr;
	}

	public void setReleaseDateStr(String releaseDateStr) {
		this.releaseDateStr = releaseDateStr;
	}

	public Integer getBlogCount() {
		return blogCount;
	}

	public void setBlogCount(Integer blogCount) {
		this.blogCount = blogCount;
	}

	public String getImagename() {
		return imagename;
	}

	public void setImagename(String imagename) {
		this.imagename = imagename;
	}
}

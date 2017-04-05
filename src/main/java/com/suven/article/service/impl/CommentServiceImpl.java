package com.suven.article.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.suven.article.entity.Comment;
import org.springframework.stereotype.Service;
import com.suven.article.dao.CommentDao;
import com.suven.article.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by fp942 on 2017/3/3.
 */
@Service("commentService")
public class CommentServiceImpl implements CommentService {

    @Resource
    private CommentDao commentDao;

    public List<Comment> getCommentData(Map<String, Object> map) {
        return commentDao.getCommentData(map);
    }

    public int addComment(Comment comment) {
        return commentDao.addComment(comment);
    }

    public Long getTotal(Map<String, Object> map) {
        return commentDao.getTotal(map);
    }

    public Integer update(Comment comment) {
        return commentDao.update(comment);
    }

    public Integer deleteComment(Integer id) {
        return commentDao.deleteComment(id);
    }

    public Integer deleteCommentByBlogId(Integer blogId) {
        return commentDao.deleteCommentByBlogId(blogId);
    }
}

package kr.co.msync.web.module.security;

import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.AuthType;
import kr.co.msync.web.module.common.type.UserStatusType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.user.dao.UserMapper;
import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import kr.co.msync.web.module.user.model.res.UserInfoResVO;
import kr.co.msync.web.module.util.SessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.ArrayList;
import java.util.List;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CommonService commonService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("## [로그인] 로그인시도 아이디 === {}", username);

        if (username != null || username.equals("")) {
            username = StringUtils.defaultString(username).replaceAll("\\p{Z}", "");
            username = username.replace("<", "&lt;").replace(">", "&gt;");
            username = username.replace("'", "&quot;").replace("\"", "&#39;");
        } else {
            log.info("## [로그인] 아이디 없음", username);
            throw new UsernameNotFoundException("Login Fail");
        }

        UserInfoReqVO reqVO = new UserInfoReqVO();
        reqVO.setLogin_id(username);
        reqVO.setDel_yn(YesNoType.NO.getValue());

        UserInfoResVO resVO = userMapper.getUserInfo(reqVO);

        if (resVO == null || resVO.getNo_user() == null || resVO.getNo_user().equals("")) {
            log.info("## [로그인] 일치하는 정보 없음 === {}", username);
            throw new UsernameNotFoundException("일치하는 정보가 존재하지 않습니다.");
        }

        if (resVO.getUser_status() == null || resVO.getUser_status().equals(UserStatusType.대기.getValue()) || resVO.getUser_status().equals(UserStatusType.반려.getValue())) {
            log.info("## [로그인] 사용 승인이 안 된 계정으로 로그인 === {}", resVO);
            throw new UsernameNotFoundException("사용 승인이 안된 계정입니다.");
        }

        List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>(1);

        if (resVO.getUser_grt() == null) {
            log.info("## [로그인] 등록된 권한 정보가 없음 === {}", username);
            throw new UsernameNotFoundException("권한 정보가 존재하지 않습니다.");
        }

        if (resVO.getUser_status().equals(UserStatusType.반려.getValue())) {
            SessionUtil.setSession("roleRule", UserStatusType.반려.getValue());
            log.info("## [로그인] 승인거부 된 계정으로 로그인 === {}", resVO);
            throw new UsernameNotFoundException("사용 승인이 거부된 계정입니다.");
        } else if (resVO.getUser_grt().equals(AuthType.ADMIN.getValue())) {
            SessionUtil.setSession("roleRule", AuthType.ADMIN.getValue());
            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else if (resVO.getUser_grt().equals(AuthType.MANAGER.getValue())) {
            SessionUtil.setSession("roleRule", AuthType.MANAGER.getValue());
            authorities.add(new SimpleGrantedAuthority("ROLE_MANAGER"));
        } else if (resVO.getUser_grt().equals(AuthType.USER.getValue())) {
            SessionUtil.setSession("roleRule", AuthType.USER.getValue());
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        CustomUserDetails userDetails = new CustomUserDetails(
                authorities,
                resVO.getNo_user(),
                resVO.getLogin_id(),
                resVO.getUser_name(),
                resVO.getUser_company(),
                resVO.getUser_channel(),
                resVO.getPassword(),
                resVO.getUser_grt(),
                resVO.getReg_way(),
                resVO.getUser_status(),
                resVO.getReg_date(),
                resVO.getMod_date(),
                true,
                true,
                true,
                true
        );

        return userDetails;
    }
}
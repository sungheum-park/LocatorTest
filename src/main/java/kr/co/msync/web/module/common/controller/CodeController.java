package kr.co.msync.web.module.common.controller;

import kr.co.msync.web.module.common.service.CodeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Slf4j
@Controller
public class CodeController extends BaseController {

	@Autowired
	private CodeService codeService;

}
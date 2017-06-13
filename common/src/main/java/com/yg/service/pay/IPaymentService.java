package com.yg.service.pay;

import com.yg.base.BaseResult;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * Created by Administrator on 2015/10/19.
 */
@Transactional(rollbackFor = Exception.class,propagation = Propagation.NESTED)
public interface IPaymentService {
    static final String CHARSET = "UTF-8";

    public enum TradeType{
        recharge("付款"),withdraw("提现"),confirmPay("确认支付"),refund("退款");

        private String remark;
        public String getRemark() {
            return remark;
        }
        TradeType(String remark){
            this.remark=remark;
        }
    }

    //充值 提现,代收,代付,批量代收,批量代付
    public BaseResult recharge(Map<String,String> param);

    public BaseResult withdraw(Map<String,String> param);

    BaseResult confirmPay(Map<String, String> param);
    BaseResult checkResult( Map<String, String> param);
    BaseResult refund(Map<String, String> param);
}

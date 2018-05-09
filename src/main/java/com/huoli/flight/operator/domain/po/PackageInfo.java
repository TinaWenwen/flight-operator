package com.huoli.flight.operator.domain.po;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
public class PackageInfo {

    private Integer id;
    private String name;
    private String code;
    private String detail;
    private String startDate;
    private String endDate;
    /* 是否仅提供发票 1:是  0: 否 */
    private Integer type;
    private Integer status;
    private Integer buyType;
    /* 是否可退 */
    private Integer rfdFlag;
    /* 是否可修改 */
    private Integer chgFlag;
    private Date createTime;

    @java.beans.ConstructorProperties({"id", "name", "code", "detail", "startDate", "endDate", "type", "status", "buyType", "rfdFlag", "chgFlag", "createTime"})
    PackageInfo(Integer id, String name, String code, String detail, String startDate, String endDate, Integer type, Integer status, Integer buyType, Integer rfdFlag, Integer chgFlag, Date createTime) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.detail = detail;
        this.startDate = startDate;
        this.endDate = endDate;
        this.type = type;
        this.status = status;
        this.buyType = buyType;
        this.rfdFlag = rfdFlag;
        this.chgFlag = chgFlag;
        this.createTime = createTime;
    }

    public static PackageInfoBuilder builder() {
        return new PackageInfoBuilder();
    }

    public static class PackageInfoBuilder {
        private Integer id;
        private String name;
        private String code;
        private String detail;
        private String startDate;
        private String endDate;
        private Integer type;
        private Integer status;
        private Integer buyType;
        private Integer rfdFlag;
        private Integer chgFlag;
        private Date createTime;

        PackageInfoBuilder() {
        }

        public PackageInfoBuilder id(Integer id) {
            this.id = id;
            return this;
        }

        public PackageInfoBuilder name(String name) {
            this.name = name;
            return this;
        }

        public PackageInfoBuilder code(String code) {
            this.code = code;
            return this;
        }

        public PackageInfoBuilder detail(String detail) {
            this.detail = detail;
            return this;
        }

        public PackageInfoBuilder startDate(String startDate) {
            this.startDate = startDate;
            return this;
        }

        public PackageInfoBuilder endDate(String endDate) {
            this.endDate = endDate;
            return this;
        }

        public PackageInfoBuilder type(Integer type) {
            this.type = type;
            return this;
        }

        public PackageInfoBuilder status(Integer status) {
            this.status = status;
            return this;
        }

        public PackageInfoBuilder buyType(Integer buyType) {
            this.buyType = buyType;
            return this;
        }

        public PackageInfoBuilder rfdFlag(Integer rfdFlag) {
            this.rfdFlag = rfdFlag;
            return this;
        }

        public PackageInfoBuilder chgFlag(Integer chgFlag) {
            this.chgFlag = chgFlag;
            return this;
        }

        public PackageInfoBuilder createTime(Date createTime) {
            this.createTime = createTime;
            return this;
        }

        public PackageInfo build() {
            return new PackageInfo(id, name, code, detail, startDate, endDate, type, status, buyType, rfdFlag, chgFlag, createTime);
        }

        public String toString() {
            return "PackageInfo.PackageInfoBuilder(id=" + this.id + ", name=" + this.name + ", code=" + this.code + ", detail=" + this.detail + ", startDate=" + this.startDate + ", endDate=" + this.endDate + ", type=" + this.type + ", status=" + this.status + ", buyType=" + this.buyType + ", rfdFlag=" + this.rfdFlag + ", chgFlag=" + this.chgFlag + ", createTime=" + this.createTime + ")";
        }
    }
}

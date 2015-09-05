<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="scr_startstop_ab_description.aspx.cs" Inherits="ReportingServices.scr_startstop_ab_description" MasterPageFile="~/Site1.Master" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--    <div style="text-align:center;font-family:'Microsoft JhengHei'">
        <h2>排 污 达 标 管 理 系 统</h2>
    </div>--%>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="JsPlug/AmazeUI/css/amazeui.min.css" />
    <link rel="stylesheet" href="JsPlug/AmazeUI/css/admin.css" />
    <script type="text/javascript" src="JsPlug/AmazeUI/js/jquery.min.js"></script>
    <script type="text/javascript" src="JsPlug/AmazeUI/js/amazeui.min.js"></script>
    <div style="width: 1000px">
        <table class="am-table am-table-bordered am-table-centered">
            <tr>
                <th width="25%">标定计量点</th>
                <th width="20%">撤出时间</th>
                <th width="20%">投运时间</th>
                <th width="25%">描述</th>
                <th width="10%">操作</th>
            </tr>
            <asp:Repeater ID="rpt_RulelogS_Des" runat="server">
                <ItemTemplate>
                    <tr>
                        <td pointname="<%# Eval("pointname") %>"><%# Eval("name") %></td>
                        <td starttime="<%# Eval("starttime") %>"><%# Eval("starttime") %></td>
                        <td endtime="<%# Eval("endtime") %>"><%# Eval("endtime") %></td>
                        <td>
                            <textarea class="" disabled="disabled" cols="30" rows="1"><%# Eval("description") %></textarea></td>
                        <td>
                            <div class="am-btn-toolba">
                                <div class="am-btn-group am-btn-group-xs">
                                    <button name="btn-edit" class="am-btn am-btn-default am-btn-xs am-text-secondary am-center">编辑</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    <div>
        <webdiyer:AspNetPager ID="AspNetPager1" runat="server"
            PagingButtonLayoutType="UnorderedList" CssClass="am-pagination am-pagination-right" CurrentPageButtonClass="am-active"
            OnPageChanging="AspNetPager1_PageChanging" OnPageChanged="AspNetPager1_PageChanged" CurrentPageButtonPosition="Center"
            Width="100%" HorizontalAlign="Right" AlwaysShowFirstLastPageNumber="true" PagingButtonSpacing="10" TextBeforePageIndexBox="转到"
            TextAfterPageIndexBox="页" SubmitButtonText="Go" ShowFirstLast="False" ShowPageIndexBox="Never">
        </webdiyer:AspNetPager>
    </div>
    <!-- modal开始 -->
    <div class="am-modal am-modal-alert" tabindex="-1" id="alert">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">保存成功</div>
            <%--<div class="am-modal-bd">
                Hello world！
            </div>--%>
            <div class="am-modal-footer">
                <span class="am-modal-btn">确定</span>
            </div>
        </div>
    </div>

    <div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="modal-loading">
        <div class="am-modal-dialog">
            <div class="am-modal-hd">正在保存...</div>
            <div class="am-modal-bd">
                <span class="am-icon-spinner am-icon-spin"></span>
            </div>
        </div>
    </div>
    <!-- modal结束 -->

    <script type="text/javascript">
        $(document).ready(function () {
            $alert = $("#alert");
            $modal = $("#modal-loading");
            $("button[name='btn-edit']").click(function () {
                var isedit = $(this).text() == "编辑" ? true : false;
                if (isedit) {
                    $(this).parents("tr").first().find("textarea").attr("disabled", !isedit);
                    $(this).text("保存");
                } else {
                    $item = $(this).parents("tr").first();
                    $item.find("textarea").attr("disabled", !isedit);
                    pointname = $item.find("[pointname]").attr("pointname");
                    starttime = $item.find("[starttime]").attr("starttime");
                    endtime = $item.find("[endtime]").attr("endtime"); 
                    description = $item.find("textarea").val();
                    $.ajax({
                        type: 'POST',
                        url: '/api/Rulelog/',
                        data: { pointname: pointname, starttime: starttime, endtime: endtime, description: description },
                        datatype: "json",
                        beforeSend: function () {
                            $modal.modal();
                        },
                        success: function (data) {
                            //if (data.id)
                            //    $alert.find(".am-modal-hd").text("保存成功");
                            //else
                            //    $alert.find(".am-modal-hd").text("保存失败");
                            $alert.find(".am-modal-hd").text("保存成功");
                            $alert.modal();
                        },
                        complete: function (XMLHttpRequest, textStatus) {
                            $modal.modal('close');
                        },
                        error: function () {
                            alert('error')
                            $alert.find(".am-modal-hd").text("保存失败");
                            $alert.modal();
                            //请求出错处理
                        }
                    });
                    $(this).text("编辑");
                }
                return false;
            })
        })
    </script>
</asp:Content>

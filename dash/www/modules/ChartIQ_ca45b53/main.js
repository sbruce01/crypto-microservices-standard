define(["backbone","Handlebars","QuickBase","css!./css/app.css"],function(e,a,t){s.app=a.template({compiler:[8,">= 4.3.0"],main:function(e,a,t,n,s){var l=e.lookupProperty||function(e,a){if(Object.prototype.hasOwnProperty.call(e,a))return e[a]};return'<div class="errorMessage ui-state-header QuickStart" style="display: block;">\n    <div class="errorPanel ui-state-warning" style="pointer-events: none;">\n        <div class="errorTitle"><i class="fa fa-exclamation-circle"></i><span>QuickStart</span></div>\n        <span class="errorText '+e.escapeExpression("function"==typeof(t=null!=(t=l(t,"theme")||(null!=a?l(a,"theme"):a))?t:e.hooks.helperMissing)?t.call(null!=a?a:e.nullContext||{},{name:"theme",hash:{},data:s,loc:{start:{line:4,column:31},end:{line:4,column:40}}}):t)+"\">Please contact a member of the <a href='mailto:sales@kx.com'>sales team</a> \n            to enquire about ChartIQ</span>\n    </div>\n</div>"},useData:!0});var n=s;function s(){}return e.View.extend({initialize:function(e){e=e.dashboardViewModel.get("DashboardTheme");this.$el.html(n.app({theme:e})),this.$el.addClass("ChartIQ "+e)}})});
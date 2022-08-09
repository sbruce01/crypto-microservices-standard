define(["backbone","Handlebars","QuickBase","jstree","css!./css/app.css"],function(r,o,y,e){"use strict";var s,i=this&&this.__extends||(s=function(e,t){return(s=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(e,t){e.__proto__=t}||function(e,t){for(var o in t)Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o])})(e,t)},function(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Class extends value "+String(t)+" is not a constructor or null");function o(){this.constructor=e}s(e,t),e.prototype=null===t?Object.create(t):(o.prototype=t.prototype,new o)}),n=(d.getComponentDefinition=function(e){var t={Trigger:{type:"string",enum:["Click","Double Click","Mouse In","Mouse Out"],default:"Click",title:"Trigger Action",propertyOrder:2}},t={id:2002,componentName:"TreeView",componentDescription:"Tree view data visialization",appKey:"TreeView",css:"tree-view-component",appArgs:{websiteUrl:e.websiteUrl,json:{version:"4.7.0",Basics:{Data:"",NodeId:"",NodeParent:"",NodeText:"",NodeIcon:"",NodeOpened:"",Opened:"",Checked:"",CheckParent:!1,Selected:"",CheckOnSelected:!1,OpenOnSelected:!1,ShowSearch:!0,Template:""},Actions:[],possibleColumns:[],actionColumns:[],Style:{HideCheckboxes:!1,ShowTooltip:!0,TooltipTemplate:"",advanced:""}},schema:{type:"object",title:"Properties",_transform:function(s,i,e,n){var t;"Basics.Data"===e?s.Basics.Data?s.Basics.Data.getMeta(function(e){var e=_.fromPairs(_.map(e.columns.collection.models,function(e){return[e.get("id"),e.toJSON()]})),t=_.keys(e),e=_.filter(e,function(e){return 11===e.kdbType}).map(function(e){return e.index}),o=_.concat("",t);_.isEqual(_.clone(s.possibleColumns).sort(),_.clone(o).sort())||(s.possibleColumns=o,s.Basics.NodeId=t[0]||s.Basics.NodeId,s.Basics.NodeParent=t[1]||s.Basics.NodeParent,s.Basics.NodeText=void 0!==e[0]&&t[e[0]]||t[0]||s.Basics.NodeText),n(s,i)}):(s.Basics.NodeId="",s.Basics.NodeParent="",s.Basics.NodeText="",s.Basics.NodeIcon="",s.possibleColumns=[],n(s,i)):"Style.HideCheckboxes"===e?(e=s.Style.HideCheckboxes instanceof r.Model?s.Basics.CheckOnSelected.get("value"):s.Style.HideCheckboxes,t=s.Basics.CheckOnSelected instanceof r.Model?s.Basics.CheckOnSelected.get("value"):s.Basics.CheckOnSelected,e&&t&&(s.Basics.CheckOnSelected instanceof r.Model&&"boolean"===s.Basics.CheckOnSelected.get("_type")?s.Basics.CheckOnSelected.set("value",!1):s.Basics.CheckOnSelected=!1),n(s,i)):n()},properties:{possibleColumns:{propertyOrder:2,type:"array",format:"table",items:{type:"string"},default:[],options:{collapsed:!0,hidden:!0}},Basics:{type:"object",propertyOrder:1,title:"Basics",options:{collapsed:!1},properties:{Data:{type:"data",format:"string",title:"Data Source",default:"",propertyOrder:1},NodeId:{type:"string",title:"Node Id (unique, required, not null)",enumSource:"possibleNode",watch:{possibleNode:"root.possibleColumns"},propertyOrder:2},NodeParent:{type:"string",title:"Parent nodes (required)",enumSource:"possibleNode",watch:{possibleNode:"root.possibleColumns"},propertyOrder:3},NodeText:{type:"string",title:"Text (required)",enumSource:"possibleNode",watch:{possibleNode:"root.possibleColumns"},propertyOrder:4},NodeIcon:{type:"string",title:"Icon",enumSource:"possibleNode",watch:{possibleNode:"root.possibleColumns"},propertyOrder:5},NodeOpened:{type:"string",title:"Opened nodes",enumSource:"possibleNode",watch:{possibleNode:"root.possibleColumns"},propertyOrder:6},Opened:{type:"viewstate",title:"Opened Nodes ID",default:"",propertyOrder:7},Checked:{type:"viewstate",title:"Checked Nodes ID",default:"",propertyOrder:8},CheckParent:{default:!1,format:"checkbox",title:"Check Parent",type:"boolean",propertyOrder:9},Selected:{type:"viewstate",title:"Selected Node ID",default:"",propertyOrder:10},CheckOnSelected:{default:!1,format:"checkbox",title:"Check On Selected",type:"boolean",propertyOrder:11},OpenOnSelected:{default:!1,format:"checkbox",title:"Open On Selected",type:"boolean",propertyOrder:12},ShowSearch:{default:!1,format:"checkbox",title:"Show Search",type:"boolean",propertyOrder:13},Template:{type:"tooltipTemplate",title:"Template Text",default:"",propertyOrder:14}}},Actions:{type:"actions",propertyOrder:3,options:{collapsed:!0},fields:{map:_.extend({Current:{title:"Selection column",type:"string",enumSource:"possibleColumns",watch:{possibleColumns:"root.possibleColumns"},propertyOrder:10}},t),nav:t,query:t,url:t}},Style:{type:"object",title:"Style",options:{collapsed:!0},properties:{HideCheckboxes:{default:!1,format:"checkbox",title:"Hide Checkboxes",type:"boolean",propertyOrder:1},ShowTooltip:{default:!1,format:"checkbox",title:"Show Tooltip",type:"boolean",propertyOrder:2},TooltipTemplate:{type:"tooltipTemplate",title:"Tooltip Text Template",default:"",propertyOrder:3},advanced:{type:"css",title:"Advanced CSS",default:""}}}}}}};if(0<_.keys(e.settingsModel.attributes).length)for(var o=_.find(d.upgrades,{version:e.settingsModel.get("version")}),s=_.isNil(o)?1:d.upgrades.indexOf(o)+1;s<d.upgrades.length;s+=1){var i=d.upgrades[s];i.fn(e.settingsModel),e.settingsModel.set("version",i.version)}return t},d.defaults=function(){return d.getComponentDefinition({settingsModel:new r.Model}).appArgs.json},d.upgrades=[{version:"4.5.0D6",fn:function(e){e.set("Basics.OpenOnSelected",!1)}},{version:"4.6.0",fn:function(e){e.set("Basics.ShowSearch",!0)}},{version:"4.7.0",fn:function(e){e.set("Styles.ShowTooltip",!0),e.set("Styles.TooltipTemplate","")}}],d);function d(){}c.app=o.template({compiler:[8,">= 4.3.0"],main:function(e,t,o,s,i){return'<div class="treeview-container">\n    <div class="treeview-search">\n        <div>\n            <i class="fa fa-search"></i>\n            <input class="search" />\n            <span class="clearSearch fa fa-times" style="display: none"></span>\n        </div>\n    </div>\n    <div class="treeview-elem"></div>\n</div>'},useData:!0});var a=c;function c(){}function l(){_.extend(this,r.Events)}l.prototype.listenTo=function(e,t,o){},l.prototype.stopListening=function(e,t,o){};i(u,h=l),u.prototype.isPivot=function(){return null!==this.source&&(!!this.source.dataSet&&!!this.source.dataSet.breakdownColumns.length)},u.prototype.onData=function(e,t,o){m.DEBUG&&console.debug("[DEBUG][DATASOURCE] -> onData ",{meta:e,data:t,error:o});t=_.clone(this.meta);this.meta=this.mergeChanges(this.meta,e.columns.reset,e.columns.change,e.columns.add,e.columns.remove),o?this.updateError(this,o):this.checkMetaChange(t),this.hasDataFlag=!0,this.listener.updateDataSource(this)},u.prototype.getColumnNames=function(t){t=t||this.meta;try{return _.map(t,function(e){return[e.id,e.index]}).sort(function(e,t){return e[1]-t[1]}).map(function(e){return e[0]})}catch(e){return _.keys(t)}},u.prototype.getColTypes=function(e){e=e||this.meta;return _.map(e,function(e){return e.kdbType})},u.prototype.getColumnType=function(e){return this.meta[e]?this.meta[e].kdbType:11},u.prototype.getData=function(){return this.source?this.source.dataSet&&this.source.dataSet.collection:null},u.prototype.getKey=function(){return this.source?this.source.cid:""},u.prototype.hasData=function(){return this.hasDataFlag},u.prototype.subscribe=function(){this.source?(this.listener.updateError("noSource",void 0),this.api.subscribe(this.source,this.onData.bind(this))):this.listener.updateError("noSource",u.NODATAERROR)},u.prototype.unsubscribe=function(){this.api.unsubscribe(this.source)},u.prototype.updateDataSource=function(e){this.listener.updateDataSource(e)},u.prototype.updateSourceSubscribe=function(e){this.hasDataFlag=!1,this.unsubscribe(),this.source=e,this.updateQueryListener(),this.subscribe()},u.prototype.updateError=function(e,t){this.listener.updateError(e,t)},u.prototype.checkMetaChange=function(e){var t=this.getColumnNames(e),o=this.getColumnNames(),e=this.getColTypes(e),s=this.getColTypes();_.isEqual(t,o)&&_.isEqual(e,s)?this.metaChanged=!1:this.metaChanged=!0},u.prototype.mergeChanges=function(t,e,o,s,i){return e&&(t=_.fromPairs(_.map(e,function(e){return[e.id,e]}))),o&&_.each(o,function(e){return _.extend(t[e.id],e)}),s&&_.each(s,function(e){t[e.id]=e}),i&&_.each(i,function(e){delete t[e.id]}),t},u.prototype.updateQueryListener=function(){this.stopListening(this.source,"change:queryStatus",this.updateError.bind(this)),this.source&&this.listenTo(this.source,"change:queryStatus",this.updateError.bind(this))},u.NODATAERROR=t("To populate this component, please define a")+" <b> "+t("Data Source")+"</b> "+t("from")+"<b> "+t("Properties")+"-"+t("Basics")+"</b>";var h,p=u;function u(e,t,o){var s=h.call(this)||this;return s.metaChanged=!1,s.hasDataFlag=!1,s.meta={},s.source=e,s.listener=t,s.api=o,s.updateQueryListener(),s}var f,g=["map","nav","query","url"],m=(f=r.View,i(b,f),b.prototype.onSettingsChange=function(e){var o=this;this.callIfDef(e,b.PROP_DATA,this.onDataSourceChange.bind(this)),_.each(e,function(e,t){-1!==t.indexOf("Actions")?o.viewModel.set(t,e):o.viewModel.set(b.SETTINGS_MAP[t],e)}),this.firstOnSettingsChange&&(this.firstOnSettingsChange=!1,this.renderTreeView())},b.prototype.updateError=function(e,t){var o,e=e.cid||e;b.DEBUG&&console.log("Update query error "+e+" ",t),t?this.errors[e]=t:this.errors[e]||this.errors.dataError?e&&delete this.errors[e]:this.errors={},_.isObject(t)&&_.keys(this.errors).length?(o=this.errors[e].error||"",this.api.showQueryStatus({error:o,type:this.errors[e].type})):e&&t?this.api.showQueryStatus({error:t,type:"Warning"}):_.keys(this.errors).length||this.api.hideQueryStatus()},b.prototype.onResizeStop=function(){this.debouncedRedraw()},b.prototype.remove=function(){return this.destroyTreeView(),this.unsubscribeTemplate(),this.unsubscribeTemplate(!0),r.View.prototype.remove.apply(this)},b.prototype.setTheme=function(){this.renderTreeView()},b.prototype.updateDataSource=function(e){this.data=e.getData(),this.columnNames=e.getColumnNames(),this.columnTypes=e.getColTypes(),this.renderTreeView()},b.prototype.initializeEvents=function(){var e=_.debounce(this.onSearchInputKeyUp.bind(this),250);this.listenTo(this.viewModel,"change:Actions",this.onActionsChange.bind(this)),this.listenTo(this.viewModel,"change:Cols",this.onNodeColsChange.bind(this)),this.listenTo(this.viewModel,"change:checked",this.onNodesCheckedChange.bind(this)),this.listenTo(this.viewModel,"change:opened",this.onNodesOpenedChange.bind(this)),this.listenTo(this.viewModel,"change:selected",this.onSelectedChange.bind(this)),this.listenTo(this.viewModel,"change:template",this.onTemplateChange.bind(this)),this.listenTo(this.viewModel,"change:titleTemplate",this.onTooltipTemplateChange.bind(this)),this.listenTo(this.viewModel,"change:showSearch",this.onToggleSearch.bind(this)),this.listenTo(this.viewModel,"change:hideCheckboxes",this.onHideCheckboxes.bind(this)),this.listenTo(this.viewModel,"change:checkParent checkOnSelected openOnSelected",this.onInteractionChange.bind(this)),this.listenTo(this.viewModel,"change:showTooltip",this.redrawTreeView.bind(this)),this.$searchInput.keyup(e),this.$clearSearch.click(this.onSearchClearClick.bind(this))},b.prototype.callIfDef=function(e,t,o){void 0!==e[t]&&o.call(this,e[t],t)},b.prototype.doActions=function(n,r){var d=this,e=this.viewModel.get("Actions"),a=[],c=this.firstOnActionsChange?["map"]:g;null!==this.data&&this.data.models&&this.data.models.length&&!_.keys(this.errors).length&&(_.each(e,function(e,t){var o=e.Current||null,s=d.colKeysMap.id,i=d.data.toJSON(),i=_.find(i,function(e){return d.parseNodeIds(e[s])===n.id});e.Trigger!==r&&r||_.isUndefined(i)||!_.includes(c,e._Type)||(i=i[o],a.push(_.extend({},e,{_PropertyIndex:t,Value:i})))}),this.firstOnActionsChange=!1,this.api.doActions(a,"Actions"))},b.prototype.destroyTreeView=function(){this.$tree.off("keydown",this.onKeyPress.bind(this)),this.$tree.jstree("destroy"),this.treeModel=null},b.prototype.generateDataObj=function(){var c=this,l=this.colKeysMap.id,h=this.colKeysMap.parent,p=this.colKeysMap.text,u=this.colKeysMap.icon,e=this.colKeysMap.opened,e=(e&&null!==this.data?this.openedNodes.opened=this.data.pluck(e).filter(function(e){return null!==e}).map(function(e){return c.parseNodeIds(e)}):this.openedNodes.viewstate.length&&(this.openedNodes.opened=this.openedNodes.viewstate),null!==this.data?this.data.toJSON():{}),e=_.map(e,function(e){var o=c.parseNodeIds(e[l]),s=c.parseNodeIds(e[h],!0),i=(o.length||y.Log.Warn(t("Node id can not be null or undefined")),_.includes(c.selectedNodesId.viewstate,o)),n=_.includes(c.openedNodes.opened,o),r=c.template?c.template(_.extend(e,c.templateVs)):e[p],d={class:"treenode-id-"+o.replace(/[~!@$%^&*\(\)+=,./';:"?><\[\]\{}|`#]/g,"-")},a=c.tooltipTemplate?c.tooltipTemplate(_.extend(e,c.tooltipTemplateVs)):r;return c.viewModel.get("showTooltip")&&(d.title=a),{id:o,parent:s,text:r,icon:_.isString(e[u])?e[u]:"",state:{opened:n,selected:i},li_attr:d}});return b.DEBUG&&console.log("Config ",e),e},b.prototype.parseNodeIds=function(e,t){var o="";return _.isNull(e)||_.isUndefined(e)?_.isNull(e)&&t&&(o="#"):0===(o=e.toString?e.toString():String(e)).length&&t&&(o="#"),o},b.prototype.filterTreeModelIdByValue=function(t,o){var e=[];return e=this.treeModel?_.filter(this.treeModel.data,function(e){return _.get(e,t)===o}).map(function(e){return e.id}):e},b.prototype.getParentNodeIds=function(){var e=[];return this.treeModel?e=_.uniq(_.filter(this.treeModel.data,function(e){return e.parent&&"#"!==e.parent}).map(function(e){return e.parent})):y.Log.Warn("treeModel was not present"),e},b.prototype.initTreeEvents=function(){var o=this;this.$tree.on("ready.jstree",function(e,t){o.treeModel=t.instance._model,o.$tree.on("check_node.jstree",o.debouncedTreeItemCheck.bind(o)),o.$tree.on("uncheck_node.jstree",o.debouncedTreeItemCheck.bind(o)),o.$tree.on("uncheck_all.jstree",o.onTreeUncheckAll.bind(o)),o.$tree.on("hover_node.jstree",o.onTreeItemEvent.bind(o)),o.$tree.on("dehover_node.jstree",o.onTreeItemEvent.bind(o)),o.$tree.on("activate_node.jstree",o.onTreeItemEvent.bind(o)),o.$tree.on("select_node.jstree",o.updateSelectedNodesVS.bind(o)),o.$tree.on("open_all.jstree",o.onTreeItemExpand.bind(o)),o.$tree.on("open_node.jstree",o.onTreeItemExpand.bind(o)),o.$tree.on("close_node.jstree",o.onTreeItemExpand.bind(o)),o.$tree.on("after_open.jstree",o.onTreeItemAfterOpen.bind(o)),o.$tree.on("keydown",o.onKeyPress.bind(o)),o.$tree.on("dblclick ","li.jstree-node",o.onDoubleClick.bind(o)),o.$tree.on("load_node.jstree",function(e,t){o.redrawing=!1,o.onSearchInputKeyUp(!0),b.DEBUG&&console.log("status ",t)}),o.$tree.on("search.jstree",function(e,t){0===t.nodes.length&&o.$tree.jstree(!0).hide_all(!1)}),o.pendingNodeCheckUpdate&&o.updatedCheckedNodes()})},b.prototype.jstreeSearch=function(e){this.$tree.jstree(!0).show_all(!1),this.$tree.jstree().search(e)},b.prototype.onActionsChange=function(e){var e=!_.filter(e.get("Actions"),function(e){return"Double Click"===e.Trigger}).length,t=e!==this.dbClickExpand;this.dbClickExpand=e,!this.firstOnSettingsChange&&t&&this.renderTreeView()},b.prototype.onDoubleClick=function(e){var t;$(e.currentTarget).hasClass("jstree-node")&&this.treeModel&&(e.stopPropagation(),t=this.$tree.find(".jstree-hovered").parent().attr("id"),(e=_.find(this.treeModel.data,function(e){return e.id===t}))&&this.doActions(e,"Double Click"))},b.prototype.onDataSourceChange=function(e){void 0===this.dataSource||e&&this.dataSource.getKey()===e.cid||this.dataSource.updateSourceSubscribe(e),this.dataSource?this.dataSource.hasData()&&this.updateDataSource(this.dataSource):(this.dataSource=new p(e,this,this.api),this.dataSource.subscribe())},b.prototype.onInteractionChange=function(){this.renderTreeView()},b.prototype.onKeyPress=function(e){e.preventDefault();var t=e.target;32===e.keyCode&&(e=$(t).parent().attr("id"),t=_.includes(this.checkedNodes.checked,e)?"uncheck_node":"check_node",e&&this.$tree.jstree(t,[e]))},b.prototype.onNodeColsChange=function(e){e=e.get("Cols");this.colKeysMap.id=e.nodeId,this.colKeysMap.parent=e.parentId,this.colKeysMap.text=e.nodeText,this.colKeysMap.icon=e.nodeIcon,this.colKeysMap.opened=e.nodeOpened,e.nodeId&&e.parentId&&e.nodeText?(this.requiredNodeColsSet=!0,this.renderTreeView()):this.requiredNodeColsSet=!1},b.prototype.onNodesCheckedChange=function(e,t){_.isString(t)?this.checkedNodes.viewstate=t.split(","):_.isArray(t)&&(this.checkedNodes.viewstate=t),_.remove(this.checkedNodes.viewstate,function(e){return""===e}),_.isEqual(this.checkedNodes.viewstate.sort(),this.checkedNodes.checked)||this.updatedCheckedNodes()},b.prototype.onNodesOpenedChange=function(e,t){_.isString(t)&&t.length?this.openedNodes.viewstate=t.split(","):_.isArray(t)&&(this.openedNodes.viewstate=t),_.remove(this.openedNodes.viewstate,function(e){return""===e}),!_.isEqual(this.openedNodes.viewstate.sort(),this.openedNodes.opened)&&this.treeModel&&(this.ignoreCloseEvent=!0,this.$tree.jstree("close_all"),this.$tree.jstree(!0).open_node(this.openedNodes.viewstate))},b.prototype.onSearchClearClick=function(){this.$searchInput.val("").trigger("keyup")},b.prototype.onSearchInputKeyUp=function(e){var t=this.$searchInput.val();!0===e&&!t||(this.$clearSearch.toggle(!_.isEmpty(t)),this.debouncedSearch(t))},b.prototype.onSelectedChange=function(e,t){_.isString(t)&&t.length?this.selectedNodesId.viewstate=t.split(","):_.isArray(t)&&(this.selectedNodesId.viewstate=t),_.remove(this.selectedNodesId.viewstate,function(e){return""===e}),_.isEqual(this.selectedNodesId.viewstate.sort(),this.selectedNodesId.click)||(this.ignoreSelectEvent=!0,this.$tree.jstree("deselect_all"),this.$tree.jstree("select_node",this.selectedNodesId.viewstate),this.ignoreSelectEvent=!1)},b.prototype.onTemplateChange=function(e,t){this.renderTemplate(t)},b.prototype.onTooltipTemplateChange=function(e,t){this.renderTooltipTemplate(t)},b.prototype.onToggleSearch=function(e,t){this.$el.find(".treeview-container").toggleClass("search-disabled",!t),this.firstOnSettingsChange||this.onSearchClearClick()},b.prototype.onHideCheckboxes=function(e,t){this.$el.find(".treeview-container").toggleClass("hide-checkboxes",t)},b.prototype.onTreeItemCheck=function(){var t=this,e=[],o=this.getParentNodeIds();this.redrawing||!this.treeModel?b.DEBUG&&console.log("Check event ignore, node not loaded"):(e=_.difference(this.prevParentNodeIds,o),this.checkedNodes.checked=this.$tree.jstree("get_checked"),this.viewModel.get("checkParent")||(this.checkedNodes.checked=_.filter(this.treeModel.data,function(e){return _.includes(t.checkedNodes.checked,e.id)&&e.children_d&&0===e.children_d.length}).map(function(e){return e.id})),e.length?(b.DEBUG&&console.log("Paren diff ",o),this.prevParentNodeIds=o,o=_.difference(this.checkedNodes.checked,e).sort(),_.isEqual(o,this.viewModel.get("checked").sort())&&!_.isEqual(o,this.checkedNodes.checked.sort())?this.updatedCheckedNodes(o):this.updateCheckedNodesVS(o)):_.isEqual(this.checkedNodes.checked.sort(),this.checkedNodes.viewstate)||this.updateCheckedNodesVS(this.checkedNodes.checked))},b.prototype.onTreeItemEvent=function(e,t){e={activate_node:"Click",hover_node:"Mouse In",dehover_node:"Mouse Out"}[e.handleObj.type],t=t.node;e&&("Mouse In"===e?this.lastHovered=t:"Mouse Out"!==e||_.isNull(this.lastHovered)||(t=this.lastHovered),this.doActions(t,e))},b.prototype.onTreeItemExpand=function(e){e=e.handleObj.type;this.ignoreCloseEvent||(this.openedNodes.opened=this.filterTreeModelIdByValue("state.opened",!0)),_.isEqual(this.openedNodes.opened.sort(),this.openedNodes.viewstate)||"open_all"===e||this.ignoreCloseEvent||this.updateOpenedNodesVS()},b.prototype.onTreeItemAfterOpen=function(){this.ignoreCloseEvent=!1},b.prototype.onTreeUncheckAll=function(){this.uncheckAlldoActions&&(this.uncheckAlldoActions=!1)},b.prototype.renderTemplate=function(e){var t=this;e?(this.template=o.compile(e),this.unsubscribeTemplate(),this.templateSubscrKey=this.api.subscribeTemplateViewStates(e,function(e){t.templateVs=e,t.redrawTreeView()})):(this.templateVs={},this.template=null,this.redrawTreeView())},b.prototype.renderTooltipTemplate=function(e){var t=this;e?(this.tooltipTemplate=o.compile(e),this.unsubscribeTemplate(!0),this.titleTemplateSubscrKey=this.api.subscribeTemplateViewStates(e,function(e){t.tooltipTemplateVs=e,t.redrawTreeView()})):(this.tooltipTemplateVs={},this.tooltipTemplate=null,this.redrawTreeView())},b.prototype.renderTreeView=function(){var o=this.generateDataObj.bind(this),e=this.dataSource;if(this.data&&this.requiredNodeColsSet&&!this.firstOnSettingsChange){e.metaChanged&&this.destroyTreeView();try{this.errors.dataError&&this.updateError("dataError",void 0),e.isPivot()&&y.Log.Warn(t("Pivot queries are not supported")),this.$tree.jstree({core:{data:function(e,t){console.log("data ",this),t.call(this,o())},dblclick_toggle:this.dbClickExpand,force_text:!0},checkbox:{three_state:!0,cascade:"undefined",whole_node:!1,tie_selection:!1},search:{show_only_matches:!0,show_only_matches_children:!0},plugins:["checkbox","conditionalselect","changed","search"]}),e.metaChanged||!this.treeModel?this.initTreeEvents():this.redrawTreeView()}catch(e){this.destroyTreeView(),this.updateError("dataError",e)}}else this.destroyTreeView()},b.prototype.redrawTreeView=function(){this.viewModel&&this.treeModel&&(this.redrawing=!0,this.prevParentNodeIds=this.getParentNodeIds(),b.DEBUG&&console.log("Redraw triggered, parent ids",this.prevParentNodeIds),this.$tree.jstree("refresh"))},b.prototype.toggleCheckSelected=function(e){var t=_.includes(this.$tree.jstree("get_checked"),e);this.$tree.jstree(t?"uncheck_node":"check_node",[e])},b.prototype.toggleExpandedSelected=function(e){var t=_.union(this.openedNodes.opened,this.openedNodes.viewstate),t=_.includes(t,e);this.$tree.jstree(t?"close_node":"open_node",[e])},b.prototype.unsubscribeTemplate=function(e){this.templateSubscrKey&&!e?this.api.unsubscribeTemplateViewStates(this.templateSubscrKey):this.titleTemplateSubscrKey&&e&&this.api.unsubscribeTemplateViewStates(this.titleTemplateSubscrKey)},b.prototype.updateCheckedNodesVS=function(e){this.api.setProperty("Basics.Checked",e)},b.prototype.updateOpenedNodesVS=function(){this.api.setProperty("Basics.Opened",this.openedNodes.opened)},b.prototype.updateSelectedNodesVS=function(e,t){this.selectedNodesId.click=this.filterTreeModelIdByValue("state.selected",!0),_.isEqual(this.selectedNodesId.viewstate,this.selectedNodesId.click.sort())||this.ignoreSelectEvent||this.api.setProperty("Basics.Selected",this.selectedNodesId.click.sort()),this.viewModel.get("openOnSelected")&&this.toggleExpandedSelected(t.node.id),this.viewModel.get("checkOnSelected")&&this.toggleCheckSelected(t.node.id)},b.prototype.updatedCheckedNodes=function(e){e=e||this.checkedNodes.viewstate;this.treeModel?(this.pendingNodeCheckUpdate=!1,this.$tree.jstree("uncheck_all"),this.$tree.jstree("check_node",e)):this.pendingNodeCheckUpdate=!0},b.DEBUG=!1,b.getComponentDefinition=n.getComponentDefinition,b.PROP_DATA="Basics.Data",b.SETTINGS_MAP={Actions:"Actions","Basics.Checked":"checked","Basics.Opened":"opened","Basics.Selected":"selected",possibleColumns:"possibleColumns","Basics.NodeId":"Cols.nodeId","Basics.NodeParent":"Cols.parentId","Basics.NodeText":"Cols.nodeText","Basics.NodeIcon":"Cols.nodeIcon","Basics.NodeOpened":"Cols.nodeOpened","Basics.Template":"template","Basics.CheckParent":"checkParent","Basics.CheckOnSelected":"checkOnSelected","Basics.OpenOnSelected":"openOnSelected","Basics.ShowSearch":"showSearch","Style.HideCheckboxes":"hideCheckboxes","Style.ShowTooltip":"showTooltip","Style.TooltipTemplate":"titleTemplate"},b);function b(e){var t=f.call(this,e)||this;return t.firstOnSettingsChange=!0,t.firstOnActionsChange=!0,t.requiredNodeColsSet=!1,t.pendingNodeCheckUpdate=!1,t.uncheckAlldoActions=!1,t.ignoreCloseEvent=!1,t.ignoreSelectEvent=!1,t.dbClickExpand=!0,t.redrawing=!1,t.colKeysMap={id:"",parent:"",text:"",icon:"",opened:""},t.errors={},t.data=null,t.columnTypes=[],t.columnNames=[],t.treeModel=null,t.template=null,t.tooltipTemplate=null,t.templateVs={},t.tooltipTemplateVs={},t.checkedNodes={checked:[],viewstate:[]},t.debouncedRedraw=_.debounce(t.redrawTreeView.bind(t),200),t.debouncedTreeItemCheck=_.debounce(t.onTreeItemCheck.bind(t),200),t.debouncedSearch=_.debounce(t.jstreeSearch.bind(t),250),t.openedNodes={opened:[],viewstate:[]},t.prevParentNodeIds=[],t.lastHovered=null,t.templateSubscrKey="",t.titleTemplateSubscrKey="",t.selectedNodesId={hover:[],click:[],viewstate:[]},t.viewModel=new r.DeepModel({possibleColumns:[],Actions:[],checked:"",opened:"",selected:"","Cols.nodeId":"","Cols.parentId":"","Cols.nodeText":"","Cols.nodeIcon":"","Cols.nodeOpened":"",checkParent:!1,checkOnSelected:!1,template:""}),t.api=e.api,t.$el.html(a.app({})),t.$el.addClass("treeview-app"),t.$searchInput=t.$el.find(".search"),t.$clearSearch=t.$el.find(".clearSearch"),t.$tree=t.$el.find(".treeview-elem"),t.initializeEvents(),t}return m});
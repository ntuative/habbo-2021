package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.quest.events.UnseenAchievementsCountUpdateEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.GetAchievementsComposer;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import flash.events.TimerEvent;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;

    public class AchievementController implements IDisposable, IUpdateReceiver 
    {

        private static const CATEGORIES_COLUMN_COUNT:int = 3;
        private static const CATEGORY_SPACING_X:int = 8;
        private static const CATEGORY_SPACING_Y:int = 5;
        private static const CATEGORY_SPACING_TOP:int = 6;
        private static const CATEGORY_ROWS_MAX:int = 3;
        private static const ACHIEVEMENT_ROWS_MIN:int = 2;
        private static const ACHIEVEMENT_ROWS_MAX:int = 4;
        private static const ACHIEVEMENT_COLUMNS:int = 6;
        private static const IN_LEVEL_PROGRESS_BAR_WIDTH:int = 180;
        private static const TOTAL_PROGRESS_BAR_WIDTH:int = 246;
        private static const _SafeStr_3097:uint = 12910463;
        private static const _SafeStr_3098:int = 45;
        private static const IN_LEVEL_PROGRESS_BAR_LOC:Point = new Point(115, 93);
        private static const TOTAL_PROGRESS_BAR_LOC:Point = new Point(72, 1);
        private static const _SafeStr_3099:int = 20;
        private static const ACHIEVEMENT_TOP_SPACING:int = 3;

        private var _questEngine:HabboQuestEngine;
        private var _window:IFrameWindow;
        private var _SafeStr_3100:IWindowContainer;
        private var _SafeStr_3101:IWindowContainer;
        private var _SafeStr_3102:IWindowContainer;
        private var _SafeStr_3103:IWindowContainer;
        private var _SafeStr_3104:IWindowContainer;
        private var _SafeStr_575:AchievementCategories;
        private var _SafeStr_826:AchievementCategory;
        private var _SafeStr_3105:AchievementData;
        private var _SafeStr_3094:Timer;
        private var _SafeStr_3106:Dictionary = new Dictionary();
        private var _SafeStr_3107:ProgressBar;
        private var _SafeStr_3108:ProgressBar;
        private var _SafeStr_3109:String = null;
        private var _SafeStr_3110:AchievementData;
        private var _SafeStr_3095:Timer;
        private var _SafeStr_3096:Dictionary = new Dictionary();
        private var _SafeStr_3111:Boolean;
        private var _SafeStr_3112:Dictionary = new Dictionary();

        public function AchievementController(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
            _SafeStr_3094 = new Timer(100, 1);
            _SafeStr_3094.addEventListener("timer", doBadgeRefresh);
            _SafeStr_3095 = new Timer(2000, 1);
            _SafeStr_3095.addEventListener("timer", switchIntoPendingLevel);
            _SafeStr_3096[16] = 1;
            _SafeStr_3096[28] = 6;
            _SafeStr_3096[38] = 4;
            _SafeStr_3096[39] = 3;
            _SafeStr_3096[40] = 1;
        }

        public static function moveAllChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:IWindow;
            while (_local_4 < _arg_1.numChildren)
            {
                _local_5 = _arg_1.getChildAt(_local_4);
                if ((((!(_local_5 == null)) && (_local_5.visible)) && (_local_5.height > 0)))
                {
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }

        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_2:int;
            var _local_4:IWindow;
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _local_4 = _arg_1.getChildAt(_local_2);
                if (_local_4.visible)
                {
                    _local_3 = Math.max(_local_3, (_local_4.y + _local_4.height));
                };
                _local_2++;
            };
            return (_local_3);
        }


        public function dispose():void
        {
            _questEngine = null;
            _SafeStr_3106 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_3094)
            {
                _SafeStr_3094.removeEventListener("timer", doBadgeRefresh);
                _SafeStr_3094.reset();
                _SafeStr_3094 = null;
            };
            if (_SafeStr_3095)
            {
                _SafeStr_3095.removeEventListener("timer", switchIntoPendingLevel);
                _SafeStr_3095.reset();
                _SafeStr_3095 = null;
            };
            if (_SafeStr_3107)
            {
                _SafeStr_3107.dispose();
                _SafeStr_3107 = null;
            };
            if (_SafeStr_3108)
            {
                _SafeStr_3108.dispose();
                _SafeStr_3108 = null;
            };
            _SafeStr_3100 = null;
            _SafeStr_3102 = null;
            _SafeStr_3102 = null;
            _SafeStr_3103 = null;
            _SafeStr_3104 = null;
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function isVisible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        public function close():void
        {
            _SafeStr_3112 = new Dictionary();
            broadcastUnseenAchievementsCount();
            if (_window)
            {
                _window.visible = false;
            };
        }

        private function broadcastUnseenAchievementsCount():void
        {
            var _local_2:int;
            for each (var _local_1:AchievementData in _SafeStr_3112)
            {
                if (!isSkippedForUnseenBroadcast(_local_1.badgeId))
                {
                    _local_2++;
                };
            };
            _questEngine.events.dispatchEvent(new UnseenAchievementsCountUpdateEvent(_local_2));
        }

        public function onRoomExit():void
        {
            this.close();
        }

        public function onToolbarClick():void
        {
            if (isVisible())
            {
                close();
            }
            else
            {
                show();
            };
        }

        public function ensureAchievementsInitialized():void
        {
            if (_SafeStr_575 == null)
            {
                _questEngine.send(new GetAchievementsComposer());
            };
        }

        public function show():void
        {
            if (_SafeStr_575 == null)
            {
                _questEngine.send(new GetAchievementsComposer());
                _SafeStr_3111 = true;
            }
            else
            {
                refresh();
                this._window.visible = true;
                this._window.activate();
            };
        }

        public function onAchievements(_arg_1:Array, _arg_2:String):void
        {
            if (_SafeStr_575 == null)
            {
                _SafeStr_575 = new AchievementCategories(_arg_1);
            };
            if (!_SafeStr_3111)
            {
                return;
            };
            _SafeStr_3111 = false;
            refresh();
            this._window.visible = true;
            this._window.activate();
            var _local_3:String = ((_SafeStr_3109 == null) ? _arg_2 : _SafeStr_3109);
            var _local_4:AchievementCategory = _SafeStr_575.getCategoryByCode(_local_3);
            if (_local_4 != null)
            {
                pickCategory(_local_4);
                _SafeStr_3109 = null;
            };
        }

        public function onAchievement(_arg_1:AchievementData):void
        {
            var _local_2:Boolean;
            if (_SafeStr_575 != null)
            {
                _local_2 = ((_SafeStr_3105) && (_SafeStr_3105.achievementId == _arg_1.achievementId));
                if (((!(_local_2)) && (!(_arg_1.achievementId in _SafeStr_3112))))
                {
                    _SafeStr_3112[_arg_1.achievementId] = _arg_1;
                    broadcastUnseenAchievementsCount();
                };
                if (((_local_2) && (_arg_1.level > _SafeStr_3105.level)))
                {
                    _SafeStr_3105.setMaxProgress();
                    _SafeStr_3110 = _arg_1;
                    _SafeStr_3095.start();
                }
                else
                {
                    _SafeStr_575.update(_arg_1);
                    if (_local_2)
                    {
                        _SafeStr_3105 = _arg_1;
                    };
                };
                if (((_window) && (_window.visible)))
                {
                    refresh();
                };
            };
        }

        private function getCategoryUnseenCount(_arg_1:String):int
        {
            var _local_3:int;
            for each (var _local_2:AchievementData in _SafeStr_3112)
            {
                if (_local_2.category == _arg_1)
                {
                    _local_3++;
                };
            };
            return (_local_3);
        }

        private function refresh():void
        {
            prepareWindow();
            refreshCategoryList();
            refreshCategoryListFooter();
            refreshAchievementsHeader();
            refreshAchievementList();
            refreshAchievementDetails();
            moveAllChildrenToColumn(_window.content, 0, 4);
            _window.height = (getLowestPoint(_window.content) + 45);
        }

        private function refreshCategoryList():void
        {
            var _local_3:int;
            var _local_1:Boolean;
            if (_SafeStr_826 != null)
            {
                _SafeStr_3100.visible = false;
                return;
            };
            _SafeStr_3100.visible = true;
            var _local_2:Vector.<AchievementCategory> = _SafeStr_575.categoryList;
            _local_3 = 0;
            while (true)
            {
                if (_local_3 < _local_2.length)
                {
                    refreshCategoryEntry(_local_3, _local_2[_local_3]);
                }
                else
                {
                    _local_1 = refreshCategoryEntry(_local_3, null);
                    if (_local_1) break;
                };
                _local_3++;
            };
            _SafeStr_3100.height = getLowestPoint(_SafeStr_3100);
        }

        private function refreshCategoryListFooter():void
        {
            if (_SafeStr_826 != null)
            {
                _SafeStr_3104.visible = false;
                return;
            };
            _SafeStr_3104.visible = true;
            _SafeStr_3108.refresh(_SafeStr_575.getProgress(), _SafeStr_575.getMaxProgress(), 0, 0);
        }

        private function refreshAchievementList():void
        {
            var _local_5:int;
            var _local_3:Boolean;
            var _local_2:IWindow = _window.findChildByName("achievements_list");
            if (_SafeStr_826 == null)
            {
                _local_2.visible = false;
                return;
            };
            _local_2.visible = true;
            Logger.log((((_SafeStr_826.code + " has ") + _SafeStr_826.achievements.length) + " achievemenets"));
            var _local_4:Vector.<AchievementData> = _SafeStr_826.achievements;
            while (_SafeStr_3101.numChildren > 0)
            {
                _SafeStr_3101.removeChildAt(0);
            };
            _local_5 = 0;
            while (true)
            {
                if (_local_5 < _local_4.length)
                {
                    refreshAchievementEntry(_local_5, _local_4[_local_5]);
                }
                else
                {
                    _local_3 = refreshAchievementEntry(_local_5, null);
                    if (_local_3) break;
                };
                _local_5++;
            };
            _SafeStr_3101.height = getLowestPoint(_SafeStr_3101);
            _local_2.height = (_SafeStr_3101.height + 1);
            _window.findChildByName("achievements_scrollarea").height = _local_2.height;
            var _local_1:IWindow = _window.findChildByName("achievements_scrollbar");
            _local_1.visible = achievementsNeedScrolling;
            _local_1.height = _local_2.height;
        }

        private function refreshAchievementsHeader():void
        {
            if (_SafeStr_826 == null)
            {
                _SafeStr_3103.visible = false;
                return;
            };
            _SafeStr_3103.visible = true;
            _SafeStr_3103.findChildByName("category_name_txt").caption = _questEngine.getAchievementCategoryName(_SafeStr_826.code);
            _questEngine.localization.registerParameter("achievements.details.categoryprogress", "progress", _SafeStr_826.getProgress().toString());
            _questEngine.localization.registerParameter("achievements.details.categoryprogress", "limit", _SafeStr_826.getMaxProgress().toString());
            _questEngine.setupAchievementCategoryImage(_SafeStr_3103, _SafeStr_826, false);
        }

        private function refreshAchievementDetails():void
        {
            if (_SafeStr_3105 == null)
            {
                _SafeStr_3102.visible = false;
                return;
            };
            _SafeStr_3102.visible = true;
            var _local_2:String = getAchievedBadgeId(_SafeStr_3105);
            _SafeStr_3102.findChildByName("achievement_name_txt").caption = _questEngine.localization.getBadgeName(_local_2);
            var _local_1:String = _questEngine.localization.getBadgeDesc(_local_2);
            _SafeStr_3102.findChildByName("achievement_desc_txt").caption = ((_local_1 == null) ? "" : _local_1);
            _questEngine.localization.registerParameter("achievements.details.level", "level", ((_SafeStr_3105.finalLevel) ? _SafeStr_3105.level.toString() : (_SafeStr_3105.level - 1).toString()));
            _questEngine.localization.registerParameter("achievements.details.level", "limit", _SafeStr_3105.levelCount.toString());
            _questEngine.refreshReward((!(_SafeStr_3105.finalLevel)), _SafeStr_3102, _SafeStr_3105.levelRewardPointType, _SafeStr_3105.levelRewardPoints);
            refreshBadgeImageLarge(_SafeStr_3102, _SafeStr_3105);
            _SafeStr_3107.refresh(_SafeStr_3105.currentPoints, _SafeStr_3105.scoreLimit, ((_SafeStr_3105.achievementId * 10000) + _SafeStr_3105.level), _SafeStr_3105.scoreAtStartOfLevel);
            _SafeStr_3107.visible = ((!(_SafeStr_3105.displayMethod == 1)) && (!(_SafeStr_3105.finalLevel)));
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IFrameWindow(_questEngine.getXmlWindow("Achievements"));
            _window.findChildByTag("close").procedure = onWindowClose;
            _window.findChildByName("back_button").procedure = onBack;
            _window.center();
            _window.y = 20;
            _SafeStr_3100 = IWindowContainer(_window.findChildByName("categories_cont"));
            _SafeStr_3103 = IWindowContainer(_window.findChildByName("achievements_header_cont"));
            _SafeStr_3101 = IWindowContainer(_window.findChildByName("achievements_cont"));
            _SafeStr_3102 = IWindowContainer(_window.findChildByName("achievement_cont"));
            _SafeStr_3104 = IWindowContainer(_window.findChildByName("categories_footer_cont"));
            _SafeStr_3107 = new ProgressBar(_questEngine, _SafeStr_3102, 180, "achievements.details.progress", true, IN_LEVEL_PROGRESS_BAR_LOC);
            _SafeStr_3108 = new ProgressBar(_questEngine, _SafeStr_3104, 246, "achievements.categories.totalprogress", true, TOTAL_PROGRESS_BAR_LOC);
        }

        private function refreshCategoryEntry(_arg_1:int, _arg_2:AchievementCategory):Boolean
        {
            var _local_5:int;
            var _local_3:IWindowContainer = IWindowContainer(_SafeStr_3100.getChildByName(_arg_1.toString()));
            var _local_4:int = int(Math.floor((_arg_1 / 3)));
            var _local_6:Boolean = (_local_4 < 3);
            if (_local_3 == null)
            {
                if (((_arg_2 == null) && (!(_local_6))))
                {
                    return (true);
                };
                _local_3 = IWindowContainer(_questEngine.getXmlWindow("AchievementCategory"));
                _local_3.name = _arg_1.toString();
                _SafeStr_3100.addChild(_local_3);
                _local_3.findChildByName("category_region").procedure = onSelectCategory;
                _local_3.x = ((_local_3.width + 8) * (_arg_1 % 3));
                _local_3.y = (((_local_3.height + 5) * Math.floor((_arg_1 / 3))) + 6);
            };
            _local_3.findChildByName("category_region").id = _arg_1;
            _local_3.findChildByName("category_region").visible = (!(_arg_2 == null));
            _local_3.findChildByName("category_bg_inact").visible = (_arg_2 == null);
            _local_3.findChildByName("category_bg_act").visible = (!(_arg_2 == null));
            _local_3.findChildByName("category_bg_act_hover").visible = false;
            _local_3.findChildByName("header_txt").visible = (!(_arg_2 == null));
            _local_3.findChildByName("completion_txt").visible = (!(_arg_2 == null));
            _local_3.findChildByName("category_pic_bitmap").visible = (!(_arg_2 == null));
            _local_3.findChildByName("unseen_count_border").visible = false;
            if (_arg_2)
            {
                _local_3.findChildByName("header_txt").caption = _questEngine.getAchievementCategoryName(_arg_2.code);
                _local_3.findChildByName("completion_txt").caption = ((_arg_2.getProgress() + "/") + _arg_2.getMaxProgress());
                _questEngine.setupAchievementCategoryImage(_local_3, _arg_2, true);
                _local_5 = getCategoryUnseenCount(_arg_2.code);
                if (_local_5 > 0)
                {
                    _local_3.findChildByName("unseen_count_border").visible = true;
                    _local_3.findChildByName("unseen_count").caption = _local_5.toString();
                };
                _local_3.visible = true;
            }
            else
            {
                _local_3.visible = _local_6;
            };
            return (false);
        }

        private function refreshAchievementEntry(_arg_1:int, _arg_2:AchievementData):Boolean
        {
            var _local_5:int = int((_arg_1 / achievementsColumnCount));
            var _local_8:Boolean = (_local_5 < 2);
            if (((_arg_2 == null) && (!(_local_8))))
            {
                return (true);
            };
            var _local_3:IWindowContainer = (_questEngine.getXmlWindow("Achievement") as IWindowContainer);
            _SafeStr_3101.addChild(_local_3);
            _local_3.x = ((_local_3.width + ((achievementsNeedScrolling) ? 5 : 0)) * (_arg_1 % achievementsColumnCount));
            Logger.log(((((((("Refreshing " + _arg_1) + " where count is ") + _SafeStr_826.achievements.length) + ", row=") + _local_5) + ", column=") + (_arg_1 % achievementsColumnCount)));
            _local_3.y = ((_local_3.height * _local_5) + 3);
            _local_3.findChildByName("bg_region").procedure = onSelectAchievement;
            var _local_6:IWindow = _local_3.findChildByName("bg_region");
            _local_6.id = _arg_1;
            _local_6.visible = (!(_arg_2 == null));
            var _local_4:IWindow = _local_3.findChildByName("bg_unselected_bitmap");
            var _local_7:IWindow = _local_3.findChildByName("bg_selected_bitmap");
            this.refreshBadgeImage(_local_3, _arg_2);
            _local_4.color = (((!(_arg_2 == null)) && (_arg_2.achievementId in _SafeStr_3112)) ? 12910463 : 0xFFFFFF);
            if (_arg_2)
            {
                _local_4.visible = (!(_arg_2 == _SafeStr_3105));
                _local_7.visible = (_arg_2 == _SafeStr_3105);
                _local_3.visible = true;
            }
            else
            {
                if (_local_8)
                {
                    _local_7.visible = false;
                    _local_4.visible = true;
                    _local_3.visible = true;
                }
                else
                {
                    _local_3.visible = false;
                };
            };
            return (false);
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                close();
            };
        }

        private function onSelectCategory(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int = _arg_2.id;
            Logger.log(("Category index: " + _local_3));
            if (_arg_1.type == "WME_CLICK")
            {
                pickCategory(_SafeStr_575.categoryList[_local_3]);
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    refreshMouseOver(-999);
                }
                else
                {
                    if (_arg_1.type == "WME_OVER")
                    {
                        refreshMouseOver(_local_3);
                    };
                };
            };
        }

        private function pickCategory(_arg_1:AchievementCategory):void
        {
            _SafeStr_826 = _arg_1;
            _SafeStr_3105 = _SafeStr_826.achievements[0];
            Logger.log(("Category: " + _SafeStr_826.code));
            this.refresh();
            _questEngine.send(new EventLogMessageComposer("Achievements", _SafeStr_826.code, "Category selected"));
        }

        public function selectCategoryInternalLink(_arg_1:String):void
        {
            var _local_2:AchievementCategory = ((_SafeStr_575 != null) ? _SafeStr_575.getCategoryByCode(_arg_1) : null);
            if (_local_2 != null)
            {
                pickCategory(_local_2);
            }
            else
            {
                _SafeStr_3109 = _arg_1;
            };
        }

        private function refreshMouseOver(_arg_1:int):void
        {
            var _local_4:int;
            var _local_2:Boolean;
            var _local_3:IWindowContainer;
            var _local_5:IWindow;
            _local_4 = 0;
            while (_local_4 < _SafeStr_3100.numChildren)
            {
                _local_2 = (_local_4 == _arg_1);
                _local_3 = IWindowContainer(_SafeStr_3100.getChildAt(_local_4));
                _local_3.findChildByName("category_bg_act").visible = ((!(_local_2)) && (_local_4 < _SafeStr_575.categoryList.length));
                _local_3.findChildByName("category_bg_act_hover").visible = _local_2;
                _local_5 = _local_3.findChildByName("hover_container");
                _local_5.x = ((_local_2) ? 0 : 1);
                _local_5.y = ((_local_2) ? 0 : 1);
                _local_4++;
            };
        }

        private function onSelectAchievement(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            var _local_3:int = _arg_2.id;
            _SafeStr_3105 = _SafeStr_826.achievements[_local_3];
            this.refresh();
            _questEngine.send(new EventLogMessageComposer("Achievements", _SafeStr_3105.achievementId.toString(), "Achievement selected"));
        }

        private function onBack(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Array;
            var _local_3:AchievementData;
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            if (_SafeStr_826 != null)
            {
                _local_4 = [];
                for each (_local_3 in _SafeStr_3112)
                {
                    if (_local_3.category != _SafeStr_826.code)
                    {
                        _local_4.push(_local_3);
                    };
                };
                _SafeStr_3112 = new Dictionary();
                for each (_local_3 in _local_4)
                {
                    _SafeStr_3112[_local_3.achievementId] = _local_3;
                };
                broadcastUnseenAchievementsCount();
            };
            _SafeStr_826 = null;
            _SafeStr_3105 = null;
            this.refresh();
        }

        private function refreshBadgeImage(_arg_1:IWindowContainer, _arg_2:AchievementData):void
        {
            var _local_4:IWidgetWindow = (_arg_1.findChildByName("achievement_pic_bitmap") as IWidgetWindow);
            var _local_3:IBadgeImageWidget = (_local_4.widget as IBadgeImageWidget);
            if (_arg_2 == null)
            {
                _local_4.visible = false;
                return;
            };
            IStaticBitmapWrapperWindow(IWindowContainer(_local_4.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_3.badgeId = getAchievedBadgeId(_arg_2);
            _local_3.greyscale = (!(_arg_2.firstLevelAchieved));
            _local_4.visible = true;
        }

        private function refreshBadgeImageLarge(_arg_1:IWindowContainer, _arg_2:AchievementData):void
        {
            var _local_4:IWidgetWindow = (_arg_1.findChildByName("achievement_pic_bitmap") as IWidgetWindow);
            var _local_3:IBadgeImageWidget = (_local_4.widget as IBadgeImageWidget);
            IStaticBitmapWrapperWindow(IWindowContainer(_local_4.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
            _local_3.badgeId = getAchievedBadgeId(_arg_2);
            _local_3.greyscale = (!(_arg_2.firstLevelAchieved));
            _local_4.visible = true;
        }

        private function doBadgeRefresh(_arg_1:TimerEvent):void
        {
            this._SafeStr_3094.reset();
            this.refresh();
        }

        private function switchIntoPendingLevel(_arg_1:TimerEvent):void
        {
            _SafeStr_3105 = _SafeStr_3110;
            _SafeStr_575.update(_SafeStr_3110);
            _SafeStr_3110 = null;
            this.refresh();
        }

        public function onBadgeImageReady(_arg_1:BadgeImageReadyEvent):void
        {
            if (_window == null)
            {
                return;
            };
            this._SafeStr_3106[_arg_1.badgeId] = _arg_1.badgeImage;
            if (!this._SafeStr_3094.running)
            {
                this._SafeStr_3094.start();
            };
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_3107 != null)
            {
                _SafeStr_3107.updateView();
            };
            if (_SafeStr_3108 != null)
            {
                _SafeStr_3108.updateView();
            };
        }

        private function getAchievedBadgeId(_arg_1:AchievementData):String
        {
            if (_arg_1.levelCount == 1)
            {
                return (_arg_1.badgeId);
            };
            return ((_arg_1.finalLevel) ? _arg_1.badgeId : _questEngine.localization.getPreviousLevelBadgeId(_arg_1.badgeId));
        }

        private function getPositionFix(_arg_1:int):int
        {
            return ((_SafeStr_3096[_arg_1]) ? _SafeStr_3096[_arg_1] : 0);
        }

        private function get achievementsColumnCount():int
        {
            if (achievementsNeedScrolling)
            {
                return (6 - 1);
            };
            return (6);
        }

        private function get achievementsNeedScrolling():Boolean
        {
            return ((!(_SafeStr_826 == null)) && (_SafeStr_826.achievements.length > (4 * 6)));
        }

        private function isSkippedForUnseenBroadcast(_arg_1:String):Boolean
        {
            var _local_3:Boolean;
            var _local_4:Array = _questEngine.getProperty("toolbar.unseen_notification.skipped_badge_ids").split(",");
            for each (var _local_2:String in _local_4)
            {
                if (_arg_1.search(_local_2) != -1)
                {
                    _local_3 = true;
                    break;
                };
            };
            return (_local_3);
        }

        public function getAchievementLevel(_arg_1:String, _arg_2:String):int
        {
            var _local_4:AchievementCategory;
            if (_SafeStr_575 != null)
            {
                _local_4 = _SafeStr_575.getCategoryByCode(_arg_1);
                if (_local_4 != null)
                {
                    for each (var _local_3:AchievementData in _local_4.achievements)
                    {
                        if (_local_3.badgeId.indexOf(_arg_2) == 0)
                        {
                            return ((_local_3.finalLevel) ? _local_3.level : Math.max(0, (_local_3.level - 1)));
                        };
                    };
                };
            };
            return (0);
        }


    }
}


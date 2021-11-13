package com.sulake.habbo.game.snowwar.leaderboard
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.game.snowwar.SnowWarEngine;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextLinkWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.game.snowwar.utils.WindowUtils;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.assets.IAsset;

    public class LeaderboardViewController implements IDisposable, IAvatarImageListener 
    {

        private static const STATE_FRIENDS_ALLTIME:int = 0;
        private static const STATE_ALLTIME:int = 1;
        private static const STATE_WEEKLY:int = 2;
        private static const STATE_FRIENDS_WEEKLY:int = 3;
        private static const STATE_GROUP_WEEKLY:int = 4;
        private static const STATE_GROUP_ALLTIME:int = 5;

        private var _SafeStr_2499:SnowWarEngine;
        private var _localization:IHabboLocalizationManager;
        private var _window:IWindowContainer;
        private var _disposed:Boolean;
        private var _SafeStr_448:int;
        private var _SafeStr_853:IItemListWindow;
        private var _listBorder:IWindow;
        private var _SafeStr_2522:ITextLinkWindow;
        private var _SafeStr_2523:ITextLinkWindow;
        private var _SafeStr_2524:ITextLinkWindow;
        private var _thisWeekButton:IBitmapWrapperWindow;
        private var _SafeStr_2525:ITextWindow;
        private var _allTimeButton:IBitmapWrapperWindow;
        private var _SafeStr_2526:ITextWindow;
        private var _SafeStr_2527:IRegionWindow;
        private var _SafeStr_2528:IRegionWindow;
        private var _nextWeek:IRegionWindow;
        private var _previousWeek:IRegionWindow;
        private var _weekCaption:String;
        private var _minutesUntilWeeklyReset:int;
        private var _SafeStr_2529:Timer;
        private var _avatarPlaceholders:Map;
        private var _SafeStr_2530:LeaderboardTable;
        private var _SafeStr_2531:TotalLeaderboardTable;
        private var _SafeStr_2532:TotalGroupLeaderboardTable;
        private var _SafeStr_2533:WeeklyTotalLeaderboardTable;
        private var _SafeStr_2534:WeeklyGroupLeaderboardTable;
        private var _SafeStr_2535:WeeklyFriendLeaderboardTable;
        private var _SafeStr_2536:Boolean;
        private var _selectedGame:int = 0;

        public function LeaderboardViewController(_arg_1:SnowWarEngine)
        {
            _SafeStr_2499 = _arg_1;
            _localization = _arg_1.localization;
            _avatarPlaceholders = new Map();
            _SafeStr_2536 = _SafeStr_2499.config.getBoolean("games.highscores.scrolling.enabled");
            _SafeStr_2530 = new LeaderboardTable(_SafeStr_2499);
            _SafeStr_2531 = new TotalLeaderboardTable(_SafeStr_2499);
            _SafeStr_2532 = new TotalGroupLeaderboardTable(_SafeStr_2499);
            _SafeStr_2533 = new WeeklyTotalLeaderboardTable(_SafeStr_2499);
            _SafeStr_2534 = new WeeklyGroupLeaderboardTable(_SafeStr_2499);
            _SafeStr_2535 = new WeeklyFriendLeaderboardTable(_SafeStr_2499);
            sendGetFriendsAllTimeData();
        }

        public function set selectedGame(_arg_1:int):void
        {
            _selectedGame = _arg_1;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _SafeStr_2499 = null;
            _SafeStr_853 = null;
            _listBorder = null;
            _SafeStr_2522 = null;
            _SafeStr_2523 = null;
            _SafeStr_2524 = null;
            _thisWeekButton = null;
            _SafeStr_2525 = null;
            _allTimeButton = null;
            _SafeStr_2526 = null;
            _SafeStr_2527 = null;
            _SafeStr_2528 = null;
            _nextWeek = null;
            _previousWeek = null;
            _weekCaption = null;
            _avatarPlaceholders.dispose();
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_SafeStr_2530)
            {
                _SafeStr_2530.dispose();
                _SafeStr_2530 = null;
            };
            if (_SafeStr_2531)
            {
                _SafeStr_2531.dispose();
                _SafeStr_2531 = null;
            };
            if (_SafeStr_2532)
            {
                _SafeStr_2532.dispose();
                _SafeStr_2532 = null;
            };
            if (_SafeStr_2533)
            {
                _SafeStr_2533.dispose();
                _SafeStr_2533 = null;
            };
            if (_SafeStr_2534)
            {
                _SafeStr_2534.dispose();
                _SafeStr_2534 = null;
            };
            if (_SafeStr_2535)
            {
                _SafeStr_2535.dispose();
                _SafeStr_2535 = null;
            };
            disposeWeeklyResetTimer();
            _disposed = true;
        }

        private function disposeWeeklyResetTimer():void
        {
            if (_SafeStr_2529 != null)
            {
                _SafeStr_2529.removeEventListener("timer", onTick);
                _SafeStr_2529.stop();
                _SafeStr_2529 = null;
            };
        }

        private function startWeeklyResetTimer(_arg_1:int):void
        {
            _SafeStr_2529 = new Timer(60000, _arg_1);
            _SafeStr_2529.addEventListener("timer", onTick);
            _SafeStr_2529.start();
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        private function enableAllTimeButton():void
        {
            _SafeStr_2525.textColor = 0;
            _SafeStr_2526.textColor = 0xFFFFFF;
            WindowUtils.setElementImage(_thisWeekButton, getBitmap("left_blue"));
            WindowUtils.setElementImage(_allTimeButton, getBitmap("right_black"));
        }

        private function enableThisWeekButton():void
        {
            _SafeStr_2525.textColor = 0xFFFFFF;
            _SafeStr_2526.textColor = 0;
            WindowUtils.setElementImage(_thisWeekButton, getBitmap("left_black"));
            WindowUtils.setElementImage(_allTimeButton, getBitmap("right_blue"));
        }

        public function showFriendsAllTime():void
        {
            _SafeStr_448 = 0;
            sendGetFriendsAllTimeData();
            visible = true;
            _window.caption = "${snowwar.leaderboard.friends}";
            enableAllTimeButton();
            updateWeekSelection();
            populateList();
        }

        public function showAllTime():void
        {
            _SafeStr_448 = 1;
            sendGetAllTimeData();
            visible = true;
            _window.caption = "${snowwar.leaderboard.all}";
            enableAllTimeButton();
            updateWeekSelection();
            populateList();
        }

        public function showGroupAllTime():void
        {
            _SafeStr_448 = 5;
            sendGetAllTimeGroupData();
            visible = true;
            _window.caption = "${snowwar.leaderboard.all}";
            enableAllTimeButton();
            updateWeekSelection();
            populateList();
        }

        public function showWeekly():void
        {
            _SafeStr_448 = 2;
            _SafeStr_2533.offset = 0;
            sendGetWeeklyData(0);
            visible = true;
            _window.caption = "${snowwar.leaderboard.all}";
            enableThisWeekButton();
            updateWeekSelection();
            populateList();
        }

        public function showGroupWeekly():void
        {
            _SafeStr_448 = 4;
            _SafeStr_2534.offset = 0;
            sendGetGroupWeeklyData(0);
            visible = true;
            _window.caption = "${snowwar.leaderboard.all}";
            enableThisWeekButton();
            updateWeekSelection();
            populateList();
        }

        public function showFriendsWeekly():void
        {
            _SafeStr_448 = 3;
            _SafeStr_2535.offset = 0;
            sendGetFriendsWeeklyData(0);
            visible = true;
            _window.caption = "${snowwar.leaderboard.friends}";
            enableThisWeekButton();
            updateWeekSelection();
            populateList();
        }

        public function addAllTimeData(_arg_1:Array, _arg_2:int):void
        {
            _SafeStr_2531.addEntries(_arg_1, _arg_2);
            if (((_SafeStr_448 == 1) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function addAllTimeGroupData(_arg_1:Array, _arg_2:int, _arg_3:int):void
        {
            _SafeStr_2532.addGroupEntries(_arg_1, _arg_2, _arg_3);
            if (((_SafeStr_448 == 5) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function addWeeklyData(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            disposeWeeklyResetTimer();
            _minutesUntilWeeklyReset = _arg_6;
            _weekCaption = ((_arg_1 + "/") + _arg_2);
            _SafeStr_2533.maxOffset = _arg_5;
            _SafeStr_2533.addEntries(_arg_3, _arg_4);
            if (((_SafeStr_448 == 2) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function addWeeklyGroupData(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):void
        {
            disposeWeeklyResetTimer();
            _minutesUntilWeeklyReset = _arg_6;
            _weekCaption = ((_arg_1 + "/") + _arg_2);
            _SafeStr_2534.maxOffset = _arg_5;
            _SafeStr_2534.addGroupEntries(_arg_3, _arg_4, _arg_7);
            if (((_SafeStr_448 == 4) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function addFriendAllTimeData(_arg_1:Array, _arg_2:int):void
        {
            _SafeStr_2530.addEntries(_arg_1, _arg_2);
            if (((_SafeStr_448 == 0) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function addFriendWeeklyData(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:int, _arg_5:int, _arg_6:int):void
        {
            disposeWeeklyResetTimer();
            _minutesUntilWeeklyReset = _arg_6;
            _weekCaption = ((_arg_1 + "/") + _arg_2);
            _SafeStr_2535.maxOffset = _arg_5;
            _SafeStr_2535.addEntries(_arg_3, _arg_4);
            if (((_SafeStr_448 == 3) && (visible)))
            {
                populateList();
            };
            updateWeekSelection();
        }

        public function hide():void
        {
            visible = false;
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (_disposed)
            {
                return;
            };
            var _local_2:IBitmapWrapperWindow = _avatarPlaceholders.remove(_arg_1);
            if (((_local_2) && (!(_local_2.disposed))))
            {
                setAvatarImage(_local_2, _arg_1);
            };
        }

        private function sendGetFriendsAllTimeData():void
        {
            _SafeStr_2530.revertToDefaultView(_selectedGame);
        }

        private function sendGetAllTimeData():void
        {
            _SafeStr_2531.revertToDefaultView(_selectedGame);
        }

        private function sendGetAllTimeGroupData():void
        {
            _SafeStr_2532.revertToDefaultView(_selectedGame);
        }

        private function sendGetWeeklyData(_arg_1:int):void
        {
            _SafeStr_2533.offset = _arg_1;
            _SafeStr_2533.revertToDefaultView(_selectedGame);
        }

        private function sendGetGroupWeeklyData(_arg_1:int):void
        {
            _SafeStr_2534.offset = _arg_1;
            _SafeStr_2534.revertToDefaultView(_selectedGame);
        }

        private function sendGetFriendsWeeklyData(_arg_1:int):void
        {
            _SafeStr_2535.offset = _arg_1;
            _SafeStr_2535.revertToDefaultView(_selectedGame);
        }

        private function get visible():Boolean
        {
            return ((_window) && (_window.visible));
        }

        private function set visible(_arg_1:Boolean):void
        {
            if (((_arg_1) && (!(_window))))
            {
                createMainWindow();
            };
            if (_arg_1)
            {
                _window.visible = true;
                _window.activate();
            }
            else
            {
                if (_window)
                {
                    _window.visible = false;
                };
            };
        }

        private function createMainWindow():void
        {
            var _local_2:IWindow;
            var _local_1:IWindow;
            if (!_window)
            {
                _window = (WindowUtils.createWindow("snowwar_leaderboard", 1) as IWindowContainer);
                _window.center();
                _window.findChildByTag("close").addEventListener("WME_CLICK", onClose);
                _SafeStr_853 = (_window.findChildByName("list") as IItemListWindow);
                _listBorder = _window.findChildByName("listBorder");
                _SafeStr_2522 = (_window.findChildByName("changeView") as ITextLinkWindow);
                _SafeStr_2522.addEventListener("WME_CLICK", onChangeView);
                _SafeStr_2523 = (_window.findChildByName("changeGroupView") as ITextLinkWindow);
                _SafeStr_2523.addEventListener("WME_CLICK", onChangeGroupView);
                _SafeStr_2524 = (_window.findChildByName("changeFriendsView") as ITextLinkWindow);
                _SafeStr_2524.addEventListener("WME_CLICK", onChangeFriendsView);
                _local_2 = _window.findChildByName("all_time_region");
                _local_2.addEventListener("WME_DOWN", onAllTimeButtonDown);
                _local_1 = _window.findChildByName("this_week_region");
                _local_1.addEventListener("WME_DOWN", onThisWeekButtonDown);
                _allTimeButton = (_window.findChildByName("all_time_image") as IBitmapWrapperWindow);
                _thisWeekButton = (_window.findChildByName("this_week_image") as IBitmapWrapperWindow);
                _SafeStr_2526 = (_window.findChildByName("all_time_text") as ITextWindow);
                _SafeStr_2525 = (_window.findChildByName("this_week_text") as ITextWindow);
                _SafeStr_2527 = (_window.findChildByName("scrollUp") as IRegionWindow);
                addScrollButtonEventListeners(_SafeStr_2527);
                WindowUtils.setElementImage(_SafeStr_2527.getChildAt(0), getBitmap("scroll_up_normal"));
                _SafeStr_2528 = (_window.findChildByName("scrollDown") as IRegionWindow);
                addScrollButtonEventListeners(_SafeStr_2528);
                WindowUtils.setElementImage(_SafeStr_2528.getChildAt(0), getBitmap("scroll_down_normal"));
                _nextWeek = (_window.findChildByName("nextWeek") as IRegionWindow);
                _nextWeek.addEventListener("WME_CLICK", onNextWeekButton);
                _nextWeek.visible = false;
                _previousWeek = (_window.findChildByName("previousWeek") as IRegionWindow);
                _previousWeek.addEventListener("WME_CLICK", onPreviousWeekButton);
                _previousWeek.visible = false;
                updateScrollButtons();
                updateWeekSelection();
            };
        }

        private function addScrollButtonEventListeners(_arg_1:IWindow):void
        {
            _arg_1.addEventListener("WME_CLICK", onScrollButton);
            _arg_1.addEventListener("WME_OVER", onScrollButton);
            _arg_1.addEventListener("WME_OUT", onScrollButton);
            _arg_1.addEventListener("WME_DOWN", onScrollButton);
            _arg_1.addEventListener("WME_UP", onScrollButton);
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hide();
        }

        private function onChangeView(_arg_1:WindowMouseEvent):void
        {
            switch (_SafeStr_448)
            {
                case 1:
                    showAllTime();
                    return;
                case 2:
                    showWeekly();
                    return;
                default:
                    _SafeStr_448 = 2;
                    showWeekly();
            };
        }

        private function onChangeFriendsView(_arg_1:WindowMouseEvent):void
        {
            switch (_SafeStr_448)
            {
                case 0:
                    showFriendsAllTime();
                    return;
                case 3:
                    showFriendsWeekly();
                    return;
                default:
                    _SafeStr_448 = 3;
                    showFriendsWeekly();
            };
        }

        private function onChangeGroupView(_arg_1:WindowMouseEvent):void
        {
            switch (_SafeStr_448)
            {
                case 5:
                    showGroupAllTime();
                    return;
                case 4:
                    showGroupWeekly();
                    return;
                default:
                    _SafeStr_448 = 4;
                    showGroupWeekly();
            };
        }

        private function onAllTimeButtonDown(_arg_1:WindowMouseEvent):void
        {
            switch (_SafeStr_448)
            {
                case 2:
                    showAllTime();
                    return;
                case 4:
                    showGroupAllTime();
                    return;
                case 3:
                    showFriendsAllTime();
                default:
            };
        }

        private function onThisWeekButtonDown(_arg_1:WindowMouseEvent):void
        {
            switch (_SafeStr_448)
            {
                case 0:
                    showFriendsWeekly();
                    return;
                case 1:
                    showWeekly();
                    return;
                case 5:
                    showGroupWeekly();
                default:
            };
        }

        private function getCurrentLeaderboard():LeaderboardTable
        {
            var _local_1:LeaderboardTable;
            switch (_SafeStr_448)
            {
                case 0:
                    _local_1 = _SafeStr_2530;
                    break;
                case 1:
                    _local_1 = _SafeStr_2531;
                    break;
                case 2:
                    _local_1 = _SafeStr_2533;
                    break;
                case 3:
                    _local_1 = _SafeStr_2535;
                    break;
                case 5:
                    _local_1 = _SafeStr_2532;
                    break;
                case 4:
                    _local_1 = _SafeStr_2534;
                    break;
                default:
                    HabboGamesCom.log(("Invalid state " + _SafeStr_448));
            };
            return (_local_1);
        }

        private function onScrollUp():void
        {
            var _local_1:LeaderboardTable = getCurrentLeaderboard();
            if (((_local_1) && (_local_1.scrollUp())))
            {
                populateList();
            };
        }

        private function onScrollDown():void
        {
            var _local_1:LeaderboardTable = getCurrentLeaderboard();
            if (((_local_1) && (_local_1.scrollDown())))
            {
                populateList();
            };
        }

        private function onScrollButton(_arg_1:WindowMouseEvent):void
        {
            var _local_4:String;
            var _local_5:String = ((_arg_1.window == _SafeStr_2527) ? "up" : "down");
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    ((_arg_1.window == _SafeStr_2527) ? onScrollUp() : onScrollDown()); //not popped
                    return;
                case "WME_OUT":
                    _local_4 = "normal";
                    break;
                case "WME_OVER":
                    _local_4 = "hilite";
                    break;
                case "WME_DOWN":
                    _local_4 = "click";
                    break;
                case "WME_UP":
                    _local_4 = "normal";
            };
            var _local_3:String = ((("scroll_" + _local_5) + "_") + _local_4);
            var _local_2:IWindowContainer = (_arg_1.window as IWindowContainer);
            WindowUtils.setElementImage(_local_2.getChildAt(0), getBitmap(_local_3));
        }

        private function onNextWeekButton(_arg_1:WindowMouseEvent):void
        {
            if (_nextWeek.visible)
            {
                switch (_SafeStr_448)
                {
                    case 2:
                        sendGetWeeklyData((_SafeStr_2533.offset - 1));
                        return;
                    case 4:
                        sendGetGroupWeeklyData((_SafeStr_2534.offset - 1));
                        return;
                    case 3:
                        sendGetFriendsWeeklyData((_SafeStr_2535.offset - 1));
                    default:
                };
            };
        }

        private function onPreviousWeekButton(_arg_1:WindowMouseEvent):void
        {
            if (_previousWeek.visible)
            {
                switch (_SafeStr_448)
                {
                    case 2:
                        sendGetWeeklyData((_SafeStr_2533.offset + 1));
                        return;
                    case 4:
                        sendGetGroupWeeklyData((_SafeStr_2534 + 1));
                        return;
                    case 3:
                        sendGetFriendsWeeklyData((_SafeStr_2535.offset + 1));
                    default:
                };
            };
        }

        private function updateWeekSelection():void
        {
            switch (_SafeStr_448)
            {
                case 2:
                    _nextWeek.visible = (_SafeStr_2533.offset > 0);
                    _previousWeek.visible = (_SafeStr_2533.offset < _SafeStr_2533.maxOffset);
                    break;
                case 4:
                    _nextWeek.visible = (_SafeStr_2534.offset > 0);
                    _previousWeek.visible = (_SafeStr_2534.offset < _SafeStr_2534.maxOffset);
                    break;
                case 3:
                    _nextWeek.visible = (_SafeStr_2535.offset > 0);
                    _previousWeek.visible = (_SafeStr_2535.offset < _SafeStr_2535.maxOffset);
                    break;
                default:
                    _nextWeek.visible = false;
                    _previousWeek.visible = false;
            };
            if (_nextWeek.visible)
            {
                _SafeStr_2525.caption = _weekCaption;
            }
            else
            {
                _SafeStr_2525.caption = "${snowwar.leaderboard.this_week}";
            };
            switch (_SafeStr_448)
            {
                case 2:
                case 3:
                case 4:
                    if (!_nextWeek.visible)
                    {
                        showTimeUntilWeeklyReset();
                        if (_SafeStr_2529 == null)
                        {
                            startWeeklyResetTimer(_minutesUntilWeeklyReset);
                        };
                        return;
                    };
                default:
            };
            WindowUtils.hideElement(_window, "reset_text");
            disposeWeeklyResetTimer();
        }

        private function showTimeUntilWeeklyReset():void
        {
            WindowUtils.showElement(_window, "reset_text");
            var _local_4:String = "snowwar.leaderboard.weekly_reset";
            var _local_3:int = convertToDays(_minutesUntilWeeklyReset);
            var _local_1:int = convertToHours(_minutesUntilWeeklyReset);
            var _local_2:int = convertToMinutes(_minutesUntilWeeklyReset);
            _localization.registerParameter(_local_4, "days", ("" + convertToDays(_minutesUntilWeeklyReset)));
            _localization.registerParameter(_local_4, "hours", ("" + convertToHours(_minutesUntilWeeklyReset)));
            _localization.registerParameter(_local_4, "minutes", ("" + convertToMinutes(_minutesUntilWeeklyReset)));
            WindowUtils.setCaption(_window.findChildByName("reset_text"), (("${" + _local_4) + "}"));
        }

        private function onTick(_arg_1:TimerEvent):void
        {
            if (((!(_nextWeek.visible)) && ((_SafeStr_448 == 2) || (_SafeStr_448 == 3))))
            {
                if (_minutesUntilWeeklyReset > 0)
                {
                    _minutesUntilWeeklyReset--;
                };
                showTimeUntilWeeklyReset();
            };
        }

        private function convertToDays(_arg_1:int):int
        {
            return (Math.floor(((_arg_1 / 60) / 24)));
        }

        private function convertToHours(_arg_1:int):int
        {
            var _local_2:int = convertToDays(_arg_1);
            return (Math.floor(((_arg_1 - ((_local_2 * 24) * 60)) / 60)));
        }

        private function convertToMinutes(_arg_1:int):int
        {
            var _local_3:int = convertToDays(_arg_1);
            var _local_2:int = convertToHours(_arg_1);
            return ((_arg_1 - ((_local_3 * 24) * 60)) - (_local_2 * 60));
        }

        private function getData():Array
        {
            switch (_SafeStr_448)
            {
                case 0:
                    return (_SafeStr_2530.getVisibleEntries());
                case 1:
                    return (_SafeStr_2531.getVisibleEntries());
                case 2:
                    return (_SafeStr_2533.getVisibleEntries());
                case 3:
                    return (_SafeStr_2535.getVisibleEntries());
                case 5:
                    return (_SafeStr_2532.getVisibleEntries());
                case 4:
                    return (_SafeStr_2534.getVisibleEntries());
                default:
                    return (null);
            };
        }

        private function getFavouriteGroupId():int
        {
            switch (_SafeStr_448)
            {
                case 5:
                    return (_SafeStr_2532.favouriteGroupId);
                case 4:
                    return (_SafeStr_2534.favouriteGroupId);
                default:
                    return (-1);
            };
        }

        private function populateList():void
        {
            var _local_8:LeaderboardEntry;
            var _local_15:IWindowContainer;
            var _local_11:Boolean;
            var _local_13:Boolean;
            var _local_1:Boolean;
            var _local_2:IWindowContainer;
            var _local_6:IWindow;
            var _local_7:int;
            var _local_14:IWindowContainer;
            var _local_3:IWindowContainer;
            var _local_4:Array = getData();
            var _local_10:int = getFavouriteGroupId();
            var _local_9:int = _SafeStr_2499.sessionDataManager.userId;
            if (((!(_local_4)) || (_local_4.length == 0)))
            {
                _SafeStr_853.visible = false;
                _listBorder.visible = false;
                return;
            };
            var _local_5:int;
            _SafeStr_853.destroyListItems();
            var _local_12:IWindowContainer = (WindowUtils.createWindow("snowwar_leaderboard_entry") as IWindowContainer);
            while (_local_5 < _local_4.length)
            {
                _local_8 = _local_4[_local_5];
                if (_local_8)
                {
                    _local_15 = (_local_12.clone() as IWindowContainer);
                    _local_15.findChildByName("rank").caption = _local_8.rank.toString();
                    _local_15.findChildByName("score").caption = _local_8.score.toString();
                    _local_15.findChildByName("name").caption = _local_8.name;
                    _local_11 = (_local_8.gender == "g");
                    if (_local_11)
                    {
                        setGroupBadgeImage((_local_15.findChildByName("avatarImage") as IBitmapWrapperWindow), _local_8.figure);
                    }
                    else
                    {
                        setAvatarImage((_local_15.findChildByName("avatarImage") as IBitmapWrapperWindow), _local_8.figure, _local_8.gender);
                    };
                    _local_13 = ((_SafeStr_448 == 1) || (_SafeStr_448 == 5));
                    _local_1 = ((_local_13) && ((_local_8.userId == _local_9) || ((_local_11) && (_local_8.userId == _local_10))));
                    if (((((!(_local_11)) && (!(_local_8.userId == _SafeStr_2499.sessionDataManager.userId))) || ((_local_11) && (!(_local_8.userId == _local_10)))) || ((_local_1) && (_local_5 < (_local_4.length - 1)))))
                    {
                        _local_15.findChildByName("highlight").visible = false;
                        _local_15.findChildByName("divider").visible = false;
                        _local_2 = (_SafeStr_853.getListItemAt((_SafeStr_853.numListItems - 1)) as IWindowContainer);
                        if (_local_2)
                        {
                            _local_2.findChildByName("divider").visible = false;
                        };
                    };
                    _local_15.findChildByName("imageRegion").id = _local_8.userId;
                    if (_local_8.gender == "g")
                    {
                        _local_15.findChildByName("imageRegion").addEventListener("WME_CLICK", onGroupImageRegion);
                    }
                    else
                    {
                        _local_15.findChildByName("imageRegion").addEventListener("WME_CLICK", onImageRegion);
                    };
                    _SafeStr_853.addListItem(_local_15);
                };
                _local_5++;
            };
            if (((((_SafeStr_448 == 1) || (_SafeStr_448 == 5)) || (_SafeStr_448 == 2)) || (_SafeStr_448 == 4)))
            {
                if ((_local_5 % _SafeStr_2530.viewSize) != 0)
                {
                    _local_6 = _SafeStr_853.getListItemAt((_SafeStr_853.numListItems - 1));
                    _local_7 = 0;
                    while (_local_7 < ((_local_5 % _SafeStr_2530.viewSize) - 1))
                    {
                        _local_14 = (_local_12.clone() as IWindowContainer);
                        _local_14.findChildByName("rank").caption = "";
                        _local_14.findChildByName("score").caption = "";
                        _local_14.findChildByName("name").caption = "";
                        _local_14.findChildByName("highlight").visible = false;
                        _local_14.findChildByName("divider").visible = false;
                        _local_3 = (_SafeStr_853.getListItemAt((_SafeStr_853.numListItems - 1)) as IWindowContainer);
                        if (_local_3)
                        {
                            _local_3.findChildByName("divider").visible = false;
                        };
                        _local_14.removeChild(_local_14.findChildByName("imageRegion"));
                        _SafeStr_853.addListItem(_local_14);
                        _local_7++;
                    };
                    _SafeStr_853.addListItem(_local_6);
                };
            };
            _local_12.dispose();
            _local_12 = (_SafeStr_853.getListItemAt((_SafeStr_853.numListItems - 1)) as IWindowContainer);
            if (_local_12)
            {
                _local_12.findChildByName("divider").visible = false;
            };
            _SafeStr_853.visible = true;
            _listBorder.visible = true;
            updateScrollButtons();
            _window.invalidate();
        }

        private function setGroupBadgeImage(_arg_1:IBitmapWrapperWindow, _arg_2:String):void
        {
            var _local_3:BitmapData = _SafeStr_2499.sessionDataManager.getGroupBadgeImage(_arg_2);
            if (_local_3)
            {
                _avatarPlaceholders.remove(_arg_2);
                _avatarPlaceholders.add(_arg_2, _arg_1);
                WindowUtils.setElementImage(_arg_1, _local_3);
                _local_3.dispose();
            };
        }

        private function setAvatarImage(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:String=null):void
        {
            var _local_4:BitmapData;
            var _local_5:IAvatarImage = _SafeStr_2499.avatarManager.createAvatarImage(_arg_2, "h", _arg_3, this);
            if (_local_5)
            {
                _local_5.setDirection("full", 2);
                _local_4 = _local_5.getCroppedImage("head");
                if (_local_5.isPlaceholder())
                {
                    _avatarPlaceholders.remove(_arg_2);
                    _avatarPlaceholders.add(_arg_2, _arg_1);
                };
                _local_5.dispose();
            };
            WindowUtils.setElementImage(_arg_1, _local_4);
            _local_4.dispose();
        }

        private function onImageRegion(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_2499.groupsManager.showExtendedProfile(_arg_1.window.id);
        }

        private function onGroupImageRegion(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_2499.groupsManager.showGroupBadgeInfo(false, _arg_1.window.id);
        }

        private function updateScrollButtons():void
        {
            var _local_1:LeaderboardTable = getCurrentLeaderboard();
            if (((_local_1) && (_SafeStr_2536)))
            {
                _SafeStr_2527.visible = _local_1.canScrollUp();
                _SafeStr_2528.visible = _local_1.canScrollDown();
            };
        }

        private function getBitmap(_arg_1:String):BitmapData
        {
            var _local_2:IAsset = _SafeStr_2499.assets.getAssetByName(_arg_1);
            if (_local_2)
            {
                return (_local_2.content as BitmapData);
            };
            return (null);
        }


    }
}


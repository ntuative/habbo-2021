package com.sulake.habbo.friendbar.view
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
    import com.sulake.habbo.game.IHabboGameManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.view.tabs.ITab;
    import com.sulake.habbo.friendbar.view.utils.TextCropper;
    import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
    import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
    import com.sulake.habbo.friendbar.view.tabs.NewOpenMessengerTab;
    import flash.utils.Timer;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboGameManager;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.room.utils.RoomEnterEffect;
    import flash.events.TimerEvent;
    import com.sulake.habbo.friendbar.data.IFriendRequest;
    import com.sulake.habbo.friendbar.data.IFriendEntity;
    import com.sulake.habbo.friendbar.view.tabs.Tab;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.friendbar.view.tabs.NewFriendRequestTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestsTab;
    import com.sulake.habbo.friendbar.view.tabs.NewFriendEntityTab;
    import com.sulake.habbo.friendbar.view.tabs.AddFriendsTab;
    import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
    import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.friendbar.data.FriendRequest;
    import com.sulake.habbo.friendbar.view.tabs.FriendRequestTab;
    import flash.events.Event;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.friendbar.events.NotificationEvent;
    import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
    import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;

    public class HabboFriendBarView extends AbstractView implements IHabboFriendBarView, IAvatarImageListener, ILinkEventTracker
    {

        private static const TAB_WIDTH:int = 127;
        private static const _SafeStr_2323:int = 1;
        private static const USE_TOGGLE_WINDOW:Boolean = false;
        private static const _SafeStr_2436:int = 3;
        private static const MAIN_WINDOW_RESOURCE:String = "new_bar_xml";
        private static const TOGGLE_WINDOW_RESOURCE:String = "toggle_xml";
        private static const BORDER:String = "border";
        private static const LIST:String = "list";
        private static const HEADER:String = "header";
        private static const CANVAS:String = "canvas";
        private static const PIECES:String = "pieces";
        private static const TOOLS:String = "friendtools";
        private static const _SafeStr_2437:String = "collapse_left";
        private static const BUTTON_COLLAPSE_RIGHT:String = "collapse_right";
        private static const _SafeStr_2438:String = "button_left";
        private static const _SafeStr_2439:String = "button_right";
        private static const BUTTON_LEFT_PAGE:String = "button_left_page";
        private static const BUTTON_RIGHT_PAGE:String = "button_right_page";
        private static const _SafeStr_2440:String = "button_left_end";
        private static const _SafeStr_2441:String = "button_right_end";
        private static const _SafeStr_2420:String = "button_close";
        private static const _SafeStr_2442:String = "button_open";
        private static const LINK_FRIEND_LIST:String = "link_friendlist";
        private static const ICON_FIND_FRIENDS:String = "icon_find_friends";
        private static const ICON_ALL_FRIENDS:String = "icon_all_friends";
        private static const COLLAPSED_MARGIN:int = 150;
        private static const NEW_BAR_BOTTOM_OFFSET:int = 1;
        private static const NEW_BAR_RIGHT_MARGIN:int = 16;

        private var _friendBarData:IHabboFriendBarData;
        private var _gameManager:IHabboGameManager;
        private var _friendList:IHabboFriendList;
        private var _toolbar:IHabboToolbar;
        private var _SafeStr_2444:IWindowContainer;
        private var _SafeStr_2446:IWindowContainer;
        private var _SafeStr_2447:IWindowContainer;
        private var _SafeStr_2448:Vector.<ITab>;
        private var _SafeStr_2449:ITab;
        private var _SafeStr_2450:int = -1;
        private var _SafeStr_2451:int = 0;
        private var _SafeStr_2452:TextCropper;
        private var _friendListIcon:FriendListIcon;
        private var _messengerIcon:MessengerIcon;
        private var _SafeStr_2443:IWindowContainer;
        private var _SafeStr_2453:NewOpenMessengerTab;
        private var _SafeStr_2454:Boolean = true;
        private var _SafeStr_574:Timer;
        private var _SafeStr_2445:Boolean = false;
        private var _SafeStr_2455:IRegionWindow;
        private var _SafeStr_2456:IRegionWindow;
        private var _SafeStr_2457:Boolean = false;
        private var _SafeStr_2458:IStaticBitmapWrapperWindow;
        private var _SafeStr_1163:Timer;
        private var _notifyMessengerOnStartup:Boolean = false;

        public function HabboFriendBarView(_arg_1:IContext, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_2452 = new TextCropper();
            _SafeStr_2448 = new Vector.<ITab>();
            _SafeStr_2448 = new Vector.<ITab>();
        }

        public function setMessengerIconNotify(_arg_1:Boolean):void
        {
            if (_messengerIcon)
            {
                _messengerIcon.notify(_arg_1);
            };
            if (_SafeStr_2443)
            {
                notifyMessenger(_arg_1);
            };
        }

        public function get friendBarWidth():int
        {
            return ((_SafeStr_2444 == null) ? 0 : ((_SafeStr_2445) ? 150 : _SafeStr_2444.width));
        }

        public function setFriendListIconNotify(_arg_1:Boolean):void
        {
            if (_friendListIcon)
            {
                _friendListIcon.notify(_arg_1);
            };
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }), new ComponentDependency(new IIDHabboFriendBarData(), function (_arg_1:IHabboFriendBarData):void
            {
                _friendBarData = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }), new ComponentDependency(new IIDHabboGameManager(), function (_arg_1:IHabboGameManager):void
            {
                _gameManager = _arg_1;
            })]));
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1163 != null)
                {
                    _SafeStr_1163.removeEventListener("timer", onTimerEvent);
                    _SafeStr_1163.stop();
                    _SafeStr_1163 = null;
                };
                if (_SafeStr_574)
                {
                    _SafeStr_574.removeEventListener("timerComplete", onRemoveDimmer);
                    _SafeStr_574 = null;
                };
                if (_messengerIcon)
                {
                    _messengerIcon.dispose();
                    _messengerIcon = null;
                };
                if (_friendListIcon)
                {
                    _friendListIcon.dispose();
                    _friendListIcon = null;
                };
                if (_SafeStr_2447)
                {
                    _SafeStr_2447.dispose();
                    _SafeStr_2447 = null;
                };
                if (_SafeStr_2444)
                {
                    _SafeStr_2444.dispose();
                    _SafeStr_2444 = null;
                };
                if (_SafeStr_2446)
                {
                    _SafeStr_2446.dispose();
                    _SafeStr_2446 = null;
                };
                while (_SafeStr_2448.length > 0)
                {
                    ITab(_SafeStr_2448.pop()).dispose();
                };
                while (_SafeStr_2448.length > 0)
                {
                    ITab(_SafeStr_2448.pop()).dispose();
                };
                if ((((!(_friendBarData == null)) && (!(_friendBarData.disposed))) && (!(_friendBarData.events == null))))
                {
                    _friendBarData.events.removeEventListener("FBE_UPDATED", onRefreshView);
                    _friendBarData.events.removeEventListener("FIND_FRIENDS_RESULT", onFindFriendsNotification);
                    _friendBarData.events.removeEventListener("FBE_REQUESTS", onFriendRequestUpdate);
                    _friendBarData.events.removeEventListener("FBE_MESSAGE", onNewInstantMessage);
                    _friendBarData.events.removeEventListener("FBE_NOTIFICATION_EVENT", onFriendNotification);
                    _friendBarData.events.removeEventListener("AMC_EVENT", onRefreshMessengerConversations);
                };
                if (_sessionDataManager)
                {
                    _sessionDataManager.events.removeEventListener("APUE_UPDATED", onSessionDataPreferences);
                };
                if (((!(_windowManager == null)) && (!(_windowManager.disposed))))
                {
                    _windowManager.getWindowContext(1).getDesktopWindow().removeEventListener("WE_RESIZED", onDesktopResized);
                };
                _SafeStr_2452.dispose();
                _SafeStr_2452 = null;
                super.dispose();
            };
        }

        override protected function initComponent():void
        {
            context.addLinkEventTracker(this);
            _friendBarData.events.addEventListener("FBE_UPDATED", onRefreshView);
            _friendBarData.events.addEventListener("FIND_FRIENDS_RESULT", onFindFriendsNotification);
            _friendBarData.events.addEventListener("FBE_REQUESTS", onFriendRequestUpdate);
            _friendBarData.events.addEventListener("FBE_MESSAGE", onNewInstantMessage);
            _friendBarData.events.addEventListener("FBE_NOTIFICATION_EVENT", onFriendNotification);
            _friendBarData.events.addEventListener("AMC_EVENT", onRefreshMessengerConversations);
            _sessionDataManager.events.addEventListener("APUE_UPDATED", onSessionDataPreferences);
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_SafeStr_2444)
            {
                _SafeStr_2444.visible = _arg_1;
                _SafeStr_2444.activate();
            };
            if (_SafeStr_2447)
            {
                _SafeStr_2447.visible = (!(_arg_1));
                if (_SafeStr_2444)
                {
                    _SafeStr_2447.x = _SafeStr_2444.x;
                    _SafeStr_2447.y = _SafeStr_2444.y;
                    _SafeStr_2447.activate();
                };
            };
        }

        private function addDimmerToFriendBar():void
        {
            var _local_1:IWindow = _windowManager.createWindow("bar_dimmer", "", 30, 1, ((0x80 | 0x0800) | 0x01), new Rectangle(0, 0, _SafeStr_2444.width, _SafeStr_2444.height), null, 0);
            _local_1.color = 0;
            _local_1.blend = 0.3;
            _SafeStr_2444.addChild(_local_1);
            _SafeStr_2444.invalidate();
            if (_SafeStr_574 == null)
            {
                _SafeStr_574 = new Timer(RoomEnterEffect.totalRunningTime, 1);
                _SafeStr_574.addEventListener("timerComplete", onRemoveDimmer);
                _SafeStr_574.start();
            };
        }

        private function onRemoveDimmer(_arg_1:TimerEvent):void
        {
            _SafeStr_574.removeEventListener("timerComplete", onRemoveDimmer);
            _SafeStr_574 = null;
            var _local_2:IWindow = _SafeStr_2444.findChildByName("bar_dimmer");
            if (_local_2 != null)
            {
                _SafeStr_2444.removeChild(_local_2);
                _windowManager.destroy(_local_2);
            };
        }

        public function get visible():Boolean
        {
            return ((_SafeStr_2444) && (_SafeStr_2444.visible));
        }

        public function populate():void
        {
            var _local_6:int;
            var _local_2:IFriendRequest;
            var _local_15:IFriendEntity;
            var _local_9:Tab;
            var _local_7:int;
            var _local_11:Tab;
            if (!(!(_SafeStr_2444 == null)))
            {
                return;
            };
            var _local_14:int = _SafeStr_2450;
            deSelect(false);
            var _local_10:IItemListWindow = (_SafeStr_2444.findChildByName("list") as IItemListWindow);
            if (!(!(_local_10 == null)))
            {
                return;
            };
            _local_10.autoArrangeItems = false;
            var _local_4:int = _local_10.numListItems;
            _local_6 = _local_4;
            while (_local_6 > 0)
            {
                _local_10.removeListItemAt((_local_6 - 1));
                _local_6--;
            };
            while (_SafeStr_2448.length > 0)
            {
                _SafeStr_2448.pop().recycle();
            };
            updateFriendRequestCounter(_friendBarData.numFriendRequests);
            var _local_3:int = _friendBarData.numFriends;
            var _local_5:int;
            var _local_1:int = maxNumOfTabsVisible;
            var _local_12:int = ((_local_3 + ((_SafeStr_2454) ? 1 : 0)) + ((_local_5 > 0) ? 1 : 0));
            var _local_13:int = Math.min(_local_1, _local_12);
            if ((_SafeStr_2451 + _local_13) > _local_12)
            {
                _SafeStr_2451 = Math.max(0, (_SafeStr_2451 - ((_SafeStr_2451 + _local_13) - _local_12)));
            };
            var _local_8:int = _SafeStr_2451;
            if (_local_5 > 0)
            {
                if (_SafeStr_2451 == 0)
                {
                    if (_SafeStr_2448.length < _local_1)
                    {
                        if (_local_5 == 1)
                        {
                            _local_2 = _friendBarData.getFriendRequestAt(0);
                            _local_9 = NewFriendRequestTab.allocate(_local_2);
                            _SafeStr_2448.push(_local_9);
                            _local_10.addListItem(_local_9.window);
                        }
                        else
                        {
                            if (_local_5 > 1)
                            {
                                _local_9 = FriendRequestsTab.allocate(_friendBarData.getFriendRequestList());
                                _SafeStr_2448.push(_local_9);
                                _local_10.addListItem(_local_9.window);
                            };
                        };
                    };
                }
                else
                {
                    _local_8--;
                };
            };
            _local_6 = _local_8;
            while (_local_6 < (_local_3 + _local_8))
            {
                if (_local_6 >= _local_3) break;
                if (_SafeStr_2448.length >= _local_1) break;
                _local_15 = _friendBarData.getFriendAt(_local_6);
                if (_local_15.id > 0)
                {
                    _local_9 = NewFriendEntityTab.allocate(_local_15);
                    _SafeStr_2448.push(_local_9);
                    _local_10.addListItem(_local_9.window);
                };
                _local_6++;
            };
            if (_SafeStr_2454)
            {
                _local_7 = getNumberOfFindFriendsTabs(_local_1, _local_12, _local_3, _local_5);
                _local_12 = ((_local_3 + _local_7) + ((_local_5 > 0) ? 1 : 0));
                while (_local_7-- > 0)
                {
                    _local_11 = AddFriendsTab.allocate();
                    _local_10.addListItem(_local_11.window);
                    _SafeStr_2448.push(_local_11);
                };
            };
            _local_10.autoArrangeItems = true;
            if (_local_14 > -1)
            {
                selectFriendEntity(_local_14);
            };
            setCollapseButtonVisibility();
            toggleArrowButtons(((_SafeStr_2448.length < _local_12) && (_local_12 > 0)), (!(_SafeStr_2451 == 0)), ((_SafeStr_2451 + _SafeStr_2448.length) < _local_12));
            if (!_SafeStr_2457)
            {
                _SafeStr_2457 = true;
                resizeAndPopulate(false);
                resizeAndPopulate(true);
            };
        }

        private function getNumberOfFindFriendsTabs(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            if (_SafeStr_2448.length >= _arg_1)
            {
                return (0);
            };
            if (_SafeStr_2448.length >= _arg_1)
            {
                return (0);
            };
            var _local_5:int = 1;
            if ((_SafeStr_2448.length + _local_5) < 3)
            {
                _local_5 = Math.min((_arg_1 - _SafeStr_2448.length), (3 - _SafeStr_2448.length));
            };
            return (_local_5);
        }

        private function getFriendEntityTabByID(_arg_1:int):FriendEntityTab
        {
            var _local_2:FriendEntityTab;
            var _local_4:int;
            var _local_3:int = _SafeStr_2448.length;
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = (_SafeStr_2448[_local_4] as FriendEntityTab);
                if (_local_2)
                {
                    if (_local_2.friend.id == _arg_1)
                    {
                        return (_local_2);
                    };
                };
                _local_4++;
            };
            return (null);
        }

        private function isUserInterfaceReady():Boolean
        {
            return ((_SafeStr_2444) && (!(_SafeStr_2444.disposed)));
        }

        private function buildUserInterface():void
        {
            Tab.DATA = _friendBarData;
            Tab.GAMES = _gameManager;
            Tab.FRIENDS = _friendList;
            Tab.VIEW = this;
            Tab.ASSETS = assets;
            Tab.WINDOWING = _windowManager;
            Tab._SafeStr_624 = _localizationManager;
            Tab.CROPPER = _SafeStr_2452;
            Tab.TRACKING = _tracking;
            Token.WINDOWING = _windowManager;
            Token.ASSETS = assets;
            Token.GAMES = _gameManager;
            var _local_4:IAsset = assets.getAssetByName("new_bar_xml");
            _SafeStr_2444 = (_windowManager.buildFromXML((_local_4.content as XML), 1) as IWindowContainer);
            _SafeStr_2444.y = (_SafeStr_2444.parent.height - (_SafeStr_2444.height + 1));
            _SafeStr_2444.setParamFlag(0x0400, true);
            _SafeStr_2444.procedure = barWindowEventProc;
            if (RoomEnterEffect.isRunning())
            {
                addDimmerToFriendBar();
            };
            var _local_2:IWindowContainer = (_SafeStr_2444.findChildByName("friendtools") as IWindowContainer);
            _SafeStr_2458 = (_local_2.getChildByName("line") as IStaticBitmapWrapperWindow);
            _SafeStr_2443 = IWindowContainer(_local_2.findChildByName("icon_messenger"));
            if (_SafeStr_2443)
            {
                _SafeStr_2443.addEventListener("WME_CLICK", onOpenMessenger);
                _SafeStr_2443.visible = false;
            };
            var _local_3:IWindowContainer = IWindowContainer(_local_2.findChildByName("icon_all_friends"));
            if (_local_3)
            {
                _local_3.addEventListener("WME_CLICK", onOpenFriendsList);
            };
            var _local_1:IWindowContainer = IWindowContainer(_local_2.findChildByName("icon_find_friends"));
            if (_local_1)
            {
                _local_1.addEventListener("WME_CLICK", onOpenSearchFriends);
            };
            _SafeStr_2456 = (_SafeStr_2444.findChildByName("collapse_left") as IRegionWindow);
            if (_SafeStr_2456)
            {
                _SafeStr_2456.addEventListener("WME_CLICK", onCollapseFriendList);
            };
            _SafeStr_2455 = (_SafeStr_2444.findChildByName("collapse_right") as IRegionWindow);
            if (_SafeStr_2455)
            {
                _SafeStr_2455.addEventListener("WME_CLICK", onCollapseFriendList);
            };
            _windowManager.getWindowContext(1).getDesktopWindow().addEventListener("WE_RESIZED", onDesktopResized);
            populate();
            if (_notifyMessengerOnStartup)
            {
                notifyMessenger(true);
            };
        }

        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_2:BitmapData;
            var _local_3:IAvatarImage;
            if (_avatarManager)
            {
                _local_3 = _avatarManager.createAvatarImage(_arg_1, "h", null, this);
                if (_local_3)
                {
                    _local_2 = _local_3.getCroppedImage("head");
                    _local_3.dispose();
                };
            };
            return (_local_2);
        }

        public function getGroupIconBitmap(_arg_1:String):BitmapData
        {
            return (_sessionDataManager.getGroupBadgeImage(_arg_1));
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_11:IFriendEntity;
            var _local_3:int;
            var _local_10:BitmapData;
            var _local_13:IWindowContainer;
            var _local_6:IItemListWindow;
            var _local_12:IWindowContainer;
            var _local_4:IBitmapWrapperWindow;
            var _local_8:IItemListWindow = (_SafeStr_2444.findChildByName("list") as IItemListWindow);
            var _local_9:int = _friendBarData.numFriends;
            _local_3 = 0;
            while (_local_3 < _local_9)
            {
                _local_11 = _friendBarData.getFriendAt(_local_3);
                if (_local_11.figure == _arg_1)
                {
                    _local_10 = null;
                    if (_local_11.id > 0)
                    {
                        _local_10 = getAvatarFaceBitmap(_local_11.figure);
                    }
                    else
                    {
                        _local_10 = getGroupIconBitmap(_local_11.figure);
                    };
                    if (_local_10)
                    {
                        _local_13 = (_local_8.getListItemByID(_local_11.id) as IWindowContainer);
                        if (_local_13)
                        {
                            _local_6 = (_local_13.getChildByName("pieces") as IItemListWindow);
                            if (_local_6)
                            {
                                _local_12 = IWindowContainer(_local_6.getListItemByName("header"));
                                if (_local_12)
                                {
                                    _local_4 = (_local_12.findChildByName("canvas") as IBitmapWrapperWindow);
                                    _local_4.bitmap = _local_10;
                                    _local_4.width = _local_10.width;
                                    _local_4.height = _local_10.height;
                                };
                            };
                        };
                    };
                    return;
                };
                _local_3++;
            };
            var _local_5:Array = _friendBarData.getFriendRequestList();
            for each (var _local_2:FriendRequest in _local_5)
            {
                if (_local_2.figure == _arg_1)
                {
                    for each (var _local_7:Tab in _SafeStr_2448)
                    {
                        if ((_local_7 is FriendRequestTab))
                        {
                            FriendRequestTab(_local_7).avatarImageReady(_local_2, getAvatarFaceBitmap(_arg_1));
                            return;
                        };
                        if ((_local_7 is NewFriendRequestTab))
                        {
                            NewFriendRequestTab(_local_7).avatarImageReady(_local_2, getAvatarFaceBitmap(_arg_1));
                            return;
                        };
                        if ((_local_7 is FriendRequestsTab))
                        {
                            FriendRequestsTab(_local_7).avatarImageReady(_local_2, getAvatarFaceBitmap(_arg_1));
                            return;
                        };
                    };
                };
            };
        }

        private function isFriendSelected(_arg_1:IFriendEntity):Boolean
        {
            return (_SafeStr_2450 == _arg_1.id);
        }

        public function selectTab(_arg_1:ITab, _arg_2:Boolean):void
        {
            if (!_arg_1.selected)
            {
                if (_SafeStr_2449)
                {
                    deSelect(true);
                };
                _arg_1.select(_arg_2);
                _SafeStr_2449 = _arg_1;
                if ((_arg_1 is FriendEntityTab))
                {
                    _SafeStr_2450 = FriendEntityTab(_arg_1).friend.id;
                };
                if ((_arg_1 is NewFriendEntityTab))
                {
                    _SafeStr_2450 = NewFriendEntityTab(_arg_1).friend.id;
                };
            };
        }

        public function selectFriendEntity(_arg_1:int):void
        {
            if (_SafeStr_2450 == _arg_1)
            {
                return;
            };
            var _local_2:FriendEntityTab = getFriendEntityTabByID(_arg_1);
            if (_local_2)
            {
                selectTab(_local_2, false);
                _SafeStr_2450 = _arg_1;
            };
        }

        public function deSelect(_arg_1:Boolean):void
        {
            if (_SafeStr_2449)
            {
                _SafeStr_2449.deselect(_arg_1);
                _SafeStr_2449 = null;
                _SafeStr_2450 = -1;
            };
        }

        public function getIconLocation(_arg_1:String):IWindowContainer
        {
            var _local_2:IWindowContainer;
            return (IWindowContainer(_SafeStr_2444.findChildByName(_arg_1)));
        }

        private function onRefreshView(_arg_1:Event):void
        {
            if (!isUserInterfaceReady())
            {
                buildUserInterface();
            }
            else
            {
                resizeAndPopulate(true);
            };
        }

        private function onFindFriendsNotification(_arg_1:FindFriendsNotificationEvent):void
        {
            var event:FindFriendsNotificationEvent = _arg_1;
            var title:String = ((event.success) ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}");
            var text:String = ((event.success) ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}");
            _windowManager.notify(title, text, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            }, 16);
        }

        private function onFriendRequestUpdate(_arg_1:FriendRequestUpdateEvent):void
        {
            if (_friendListIcon)
            {
                _friendListIcon.notify((_friendBarData.numFriendRequests > 0));
            };
            if (_SafeStr_2444)
            {
                updateFriendRequestCounter(_friendBarData.numFriendRequests);
                resizeAndPopulate(true);
            }
            else
            {
                buildUserInterface();
            };
        }

        protected function onTimerEvent(_arg_1:TimerEvent):void
        {
            _SafeStr_2443.visible = true;
            var _local_2:IWindow = (_SafeStr_2443.getChildByName("icon_1") as IWindow);
            var _local_3:IWindow = (_SafeStr_2443.getChildByName("icon_2") as IWindow);
            if (((_local_2) && (_local_3)))
            {
                if (_local_2.visible)
                {
                    _local_2.visible = false;
                    _local_3.visible = true;
                }
                else
                {
                    if (_local_3.visible)
                    {
                        _local_3.visible = false;
                        _local_2.visible = true;
                    };
                };
            };
        }

        private function notifyMessenger(_arg_1:Boolean):void
        {
            var _local_2:IWindow = (_SafeStr_2443.getChildByName("icon") as IWindow);
            var _local_3:IWindow = (_SafeStr_2443.getChildByName("icon_1") as IWindow);
            if (_arg_1)
            {
                if (!_SafeStr_1163)
                {
                    _local_2.visible = false;
                    _local_3.visible = true;
                    _SafeStr_1163 = new Timer(500, 0);
                    _SafeStr_1163.addEventListener("timer", onTimerEvent);
                    _SafeStr_1163.start();
                };
            }
            else
            {
                if (_SafeStr_1163 != null)
                {
                    _SafeStr_1163.removeEventListener("timer", onTimerEvent);
                    _SafeStr_1163.stop();
                    _SafeStr_1163 = null;
                };
                _local_2.visible = true;
                _local_3.visible = false;
                (_SafeStr_2443.getChildByName("icon_2") as IWindow).visible = false;
            };
        }

        private function onNewInstantMessage(_arg_1:NewMessageEvent):void
        {
            if (_arg_1.notify)
            {
                _notifyMessengerOnStartup = true;
            };
            if (_SafeStr_2443)
            {
                if (_arg_1.notify)
                {
                    notifyMessenger(true);
                }
                else
                {
                    _SafeStr_2443.visible = true;
                    notifyMessenger(false);
                };
            };
            if (_SafeStr_2453)
            {
                if (_arg_1.notify)
                {
                    _SafeStr_2453.window.visible = true;
                };
            };
        }

        private function onFriendNotification(_arg_1:NotificationEvent):void
        {
            var _local_2:FriendEntityTab = getFriendEntityTabByID(_arg_1.friendId);
            if (!_local_2)
            {
                return;
            };
            _local_2.addNotificationToken(_arg_1.notification);
        }

        private function onRefreshMessengerConversations(_arg_1:ActiveConversationsCountEvent):void
        {
            if (_SafeStr_2443 != null)
            {
                _SafeStr_2443.visible = (!(_arg_1.activeConversationsCount == 0));
            };
        }

        private function onSessionDataPreferences(_arg_1:SessionDataPreferencesEvent):void
        {
            if (!(_arg_1.uiFlags & 0x01))
            {
                if (!_SafeStr_2445)
                {
                    toggleCollapsedState();
                };
            };
        }

        private function barWindowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_3:int;
            if (_arg_1.type == "WME_DOWN")
            {
                _local_4 = _SafeStr_2451;
                _local_3 = ((_friendBarData.numFriends + ((_SafeStr_2454) ? 1 : 0)) + ((_friendBarData.numFriendRequests > 0) ? 1 : 0));
                switch (_arg_2.name)
                {
                    case "button_left":
                        _local_4 = Math.max(0, (_SafeStr_2451 - 1));
                        break;
                    case "button_left_page":
                        _local_4 = Math.max(0, (_SafeStr_2451 - maxNumOfTabsVisible));
                        break;
                    case "button_left_end":
                        _local_4 = 0;
                        break;
                    case "button_right":
                        _local_4 = Math.max(0, Math.min((_local_3 - maxNumOfTabsVisible), (_SafeStr_2451 + 1)));
                        break;
                    case "button_right_page":
                        _local_4 = Math.max(0, Math.min((_local_3 - maxNumOfTabsVisible), (_SafeStr_2451 + maxNumOfTabsVisible)));
                        break;
                    case "button_right_end":
                        _local_4 = Math.max(0, (_local_3 - maxNumOfTabsVisible));
                        break;
                    case "button_close":
                        visible = false;
                        break;
                    case "border":
                        deSelect(true);
                        break;
                    case "link_friendlist":
                        _friendBarData.toggleFriendList();
                };
                if (_local_4 != _SafeStr_2451)
                {
                    deSelect(true);
                    _SafeStr_2451 = _local_4;
                    resizeAndPopulate(true);
                };
            };
            if (_arg_1.type == "WE_DEACTIVATED")
            {
                deSelect(true);
            };
        }

        private function setCollapseButtonVisibility():void
        {
            if (_SafeStr_2456)
            {
                _SafeStr_2456.visible = _SafeStr_2445;
            };
            if (_SafeStr_2455)
            {
                _SafeStr_2455.visible = (!(_SafeStr_2445));
            };
        }

        private function onCollapseFriendList(_arg_1:WindowMouseEvent):void
        {
            toggleCollapsedState();
        }

        private function toggleCollapsedState():void
        {
            _SafeStr_2445 = (!(_SafeStr_2445));
            _sessionDataManager.setFriendBarState((!(_SafeStr_2445)));
            deSelect(true);
            resizeAndPopulate(true);
            setCollapseButtonVisibility();
            if (!_SafeStr_2445)
            {
                resizeAndPopulate(true);
            };
            var _local_1:FriendBarResizeEvent = new FriendBarResizeEvent();
            events.dispatchEvent(_local_1);
        }

        private function onOpenMessenger(_arg_1:WindowMouseEvent):void
        {
            _friendBarData.toggleMessenger();
            notifyMessenger(false);
        }

        private function onOpenFriendsList(_arg_1:WindowMouseEvent):void
        {
            _friendBarData.toggleFriendList();
        }

        private function onOpenSearchFriends(_arg_1:WindowMouseEvent):void
        {
            _friendBarData.openUserTextSearch();
        }

        public function removeMessengerNotifications():void
        {
            for each (var _local_1:ITab in _SafeStr_2448)
            {
                if ((_local_1 is FriendEntityTab))
                {
                    FriendEntityTab(_local_1).removeNotificationToken(-1, true);
                };
            };
        }

        public function updateFriendRequestCounter(_arg_1:int):void
        {
            var _local_2:IRegionWindow;
            if (!_SafeStr_2446)
            {
                _SafeStr_2446 = _windowManager.createUnseenItemCounter();
            };
            if (_SafeStr_2446)
            {
                _local_2 = (_SafeStr_2444.findChildByName("icon_all_friends") as IRegionWindow);
                if (_local_2)
                {
                    _local_2.addChild(_SafeStr_2446);
                    _SafeStr_2446.x = ((_local_2.width - _SafeStr_2446.width) - 5);
                    _SafeStr_2446.y = 0;
                    if (_arg_1 > 0)
                    {
                        _SafeStr_2446.visible = true;
                        _SafeStr_2446.findChildByName("count").caption = _arg_1.toString();
                    }
                    else
                    {
                        _SafeStr_2446.visible = false;
                    };
                };
            };
        }

        private function toggleWindowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_SafeStr_2447.visible)
            {
                if (_arg_1.type == "WME_DOWN")
                {
                    switch (_arg_2.name)
                    {
                        case "button_open":
                            visible = true;
                            return;
                    };
                };
            };
        }

        private function toggleArrowButtons(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            var _local_4:IRegionWindow = (_SafeStr_2444.findChildByName("button_left_page") as IRegionWindow);
            var _local_5:IRegionWindow = (_SafeStr_2444.findChildByName("button_right_page") as IRegionWindow);
            if (_local_4 != null)
            {
                _local_4.visible = _arg_1;
                if (_arg_2)
                {
                    _local_4.enable();
                    _local_4.blend = 1;
                }
                else
                {
                    _local_4.disable();
                    _local_4.blend = 0.2;
                };
            };
            if (_local_5 != null)
            {
                _local_5.visible = _arg_1;
                if (_arg_3)
                {
                    _local_5.enable();
                    _local_5.blend = 1;
                }
                else
                {
                    _local_5.disable();
                    _local_5.blend = 0.2;
                };
            };
            arrangeWindows();
        }

        private function resizeAndPopulate(_arg_1:Boolean=false):void
        {
            var _local_2:Rectangle;
            var _local_3:int;
            if (!disposed)
            {
                if (_SafeStr_2444)
                {
                    _local_2 = _toolbar.getRect();
                    _SafeStr_2444.width = (_SafeStr_2444.parent.width - _local_2.right);
                    _SafeStr_2458.visible = (!(_SafeStr_2445));
                    if (!_arg_1)
                    {
                        _local_3 = maxNumOfTabsVisible;
                        if (_local_3 < _SafeStr_2448.length)
                        {
                            _arg_1 = true;
                        }
                        else
                        {
                            if (_local_3 > _SafeStr_2448.length)
                            {
                                if (_SafeStr_2448.length < 3)
                                {
                                    _arg_1 = true;
                                }
                                else
                                {
                                    if (_SafeStr_2448.length < (_friendBarData.numFriends + ((_SafeStr_2454) ? 1 : 0)))
                                    {
                                        _arg_1 = true;
                                    }
                                    else
                                    {
                                        if (numFriendEntityTabsVisible < _friendBarData.numFriends)
                                        {
                                            _arg_1 = true;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (_arg_1)
                    {
                        populate();
                        arrangeWindows();
                    };
                    if (_SafeStr_2445)
                    {
                        _SafeStr_2444.x = (_SafeStr_2444.desktop.width - 150);
                    }
                    else
                    {
                        _SafeStr_2444.x = (_SafeStr_2444.desktop.width - _SafeStr_2444.width);
                        _SafeStr_2458.x = 1;
                    };
                };
            };
        }

        private function arrangeWindows():void
        {
            var _local_1:int;
            for each (var _local_2:IWindow in _SafeStr_2444.iterator)
            {
                if (_local_2.visible)
                {
                    _local_2.x = _local_1;
                    _local_1 = (_local_1 + _local_2.width);
                };
            };
            _SafeStr_2444.width = _local_1;
        }

        private function get numFriendEntityTabsVisible():int
        {
            var _local_2:int;
            var _local_3:int = _SafeStr_2448.length;
            while (_local_3-- > 0)
            {
                if ((_SafeStr_2448[_local_3] is FriendEntityTab))
                {
                    _local_2++;
                };
            };
            var _local_1:int = _SafeStr_2448.length;
            while (_local_1-- > 0)
            {
                if ((_SafeStr_2448[_local_1] is FriendEntityTab))
                {
                    _local_2++;
                };
            };
            return (_local_2);
        }

        private function get maxNumOfTabsVisible():int
        {
            var _local_1:IItemListWindow = (_SafeStr_2444.findChildByName("list") as IItemListWindow);
            var _local_2:IWindowContainer = (_SafeStr_2444.findChildByName("friendtools") as IWindowContainer);
            return (int((((_SafeStr_2444.width - _local_2.width) - 16) / (127 + _local_1.spacing))));
        }

        private function onDesktopResized(_arg_1:WindowEvent):void
        {
            resizeAndPopulate(true);
        }

        public function get linkPattern():String
        {
            return ("friendbar/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "findfriends":
                    _friendBarData.findNewFriends();
                    return;
                case "user":
                    if (_local_2.length > 2)
                    {
                        _friendBarData.showProfileByName(_local_2[2]);
                    };
                    return;
                default:
                    Logger.log(("HabboFriendBarView unknown link-type received: " + _local_2[1]));
                    return;
            };
        }


    }
}
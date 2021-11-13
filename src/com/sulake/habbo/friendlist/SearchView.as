package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.utils.ExtendedProfileIcon;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
    import com.sulake.core.window.events.*;

    public class SearchView implements ITabView, ISearchView 
    {

        private var _friendList:HabboFriendList;
        private var _SafeStr_2473:ITextFieldWindow;
        private var _SafeStr_853:IItemListWindow;


        public function init(_arg_1:HabboFriendList):void
        {
            _friendList = _arg_1;
        }

        public function getEntryCount():int
        {
            if (_friendList.searchResults.friends == null)
            {
                return (0);
            };
            return (_friendList.searchResults.friends.length + _friendList.searchResults.others.length);
        }

        public function fillList(_arg_1:IItemListWindow):void
        {
            _SafeStr_853 = _arg_1;
        }

        public function fillFooter(_arg_1:IWindowContainer):void
        {
            _SafeStr_2473 = ITextFieldWindow(_arg_1.findChildByName("search_str"));
            _SafeStr_2473.procedure = onSearchInput;
            _SafeStr_2473.addEventListener("WKE_KEY_DOWN", onSearchStrInput);
            _arg_1.findChildByName("search_but").procedure = onSearchButtonClick;
            _friendList.refreshButton(_arg_1, "search", true, null, 0);
        }

        public function tabClicked(_arg_1:int):void
        {
        }

        public function refreshList():void
        {
            var _local_4:int;
            var _local_5:Boolean;
            var _local_3:HabboSearchResultData;
            var _local_6:HabboSearchResultData;
            var _local_1:Boolean;
            _SafeStr_853.autoArrangeItems = false;
            var _local_2:AvatarSearchResults = _friendList.searchResults;
            _local_4 = 0;
            while (true)
            {
                _local_5 = _friendList.isMessagesPersisted();
                if (_local_4 == 0)
                {
                    refreshEntry(true, _local_4, null, null, getFriendsCaption(), false, false, 0);
                }
                else
                {
                    if (_local_4 <= _local_2.friends.length)
                    {
                        _local_3 = _local_2.friends[(_local_4 - 1)];
                        refreshEntry(true, _local_4, _local_3.avatarFigure, _local_3.avatarName, null, ((_local_3.isAvatarOnline) || (_local_5)), false, _local_3.avatarId);
                    }
                    else
                    {
                        if (_local_4 == (_local_2.friends.length + 1))
                        {
                            refreshEntry(true, _local_4, null, null, getOthersCaption(), false, false, 0);
                        }
                        else
                        {
                            if (_local_4 <= ((_local_2.friends.length + _local_2.others.length) + 1))
                            {
                                _local_6 = _local_2.others[((_local_4 - 2) - _local_2.friends.length)];
                                refreshEntry(true, _local_4, _local_6.avatarFigure, _local_6.avatarName, null, false, ((!(_local_6.avatarId == _friendList.avatarId)) && (!(_friendList.searchResults.isFriendRequestSent(_local_6.avatarId)))), _local_6.avatarId);
                            }
                            else
                            {
                                _local_1 = refreshEntry(false, _local_4, null, null, null, false, false, 0);
                                if (_local_1) break;
                            };
                        };
                    };
                };
                _local_4++;
            };
            refreshShading();
            _SafeStr_853.autoArrangeItems = true;
        }

        private function refreshShading():void
        {
            var _local_1:int;
            _local_1 = 0;
            while (_local_1 < _SafeStr_853.numListItems)
            {
                _SafeStr_853.getListItemAt(_local_1).color = _friendList.laf.getRowShadingColor(3, ((_local_1 % 2) == 1));
                _local_1++;
            };
        }

        public function setSearchStr(_arg_1:String):void
        {
            this._SafeStr_2473.text = _arg_1;
        }

        public function focus():void
        {
            this._SafeStr_2473.focus();
        }

        private function getFriendsCaption():String
        {
            if (_friendList.searchResults.friends.length == 0)
            {
                return ("${friendlist.search.nofriendsfound}");
            };
            _friendList.registerParameter("friendlist.search.friendscaption", "cnt", ("" + _friendList.searchResults.friends.length));
            return ("${friendlist.search.friendscaption}");
        }

        private function getOthersCaption():String
        {
            if (_friendList.searchResults.others.length == 0)
            {
                return ("${friendlist.search.noothersfound}");
            };
            _friendList.registerParameter("friendlist.search.otherscaption", "cnt", ("" + _friendList.searchResults.others.length));
            return ("${friendlist.search.otherscaption}");
        }

        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:Boolean, _arg_8:int):Boolean
        {
            var _local_9:IWindowContainer = (_SafeStr_853.getListItemAt(_arg_2) as IWindowContainer);
            if (_local_9 == null)
            {
                if (!_arg_1)
                {
                    return (true);
                };
                _local_9 = IWindowContainer(_friendList.getXmlWindow("search_entry"));
                _local_9.findChildByName("bg_region").procedure = onSearchEntry;
                _SafeStr_853.addListItem(_local_9);
            };
            if (_arg_1)
            {
                _local_9.height = 20;
                _local_9.visible = true;
            }
            else
            {
                _local_9.height = 0;
                _local_9.visible = false;
            };
            _local_9.id = _arg_8;
            _local_9.findChildByName("bg_region").id = _arg_8;
            refreshFigure(_local_9, _arg_3, (_arg_8 < 0));
            _friendList.refreshText(_local_9, "name", (!(_arg_4 == null)), _arg_4);
            _friendList.refreshText(_local_9, "caption", (!(_arg_5 == null)), _arg_5);
            _friendList.refreshButton(_local_9, "start_chat", _arg_6, onChatButtonClick, _arg_8);
            _friendList.refreshButton(_local_9, "ask_for_friend", _arg_7, onAskForFriendButtonClick, _arg_8);
            ExtendedProfileIcon.setUserInfoState(false, _local_9);
            _local_9.findChildByName("user_info_region").visible = (_arg_8 > 0);
            return (false);
        }

        private function refreshFigure(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_4:IBitmapWrapperWindow = (_arg_1.getChildByName("face") as IBitmapWrapperWindow);
            if (((_arg_2 == null) || (_arg_2 == "")))
            {
                _local_4.visible = false;
            }
            else
            {
                if (_arg_3)
                {
                    _local_4.bitmap = _friendList.getSmallGroupBadgeBitmap(_arg_2);
                }
                else
                {
                    _local_4.bitmap = _friendList.getAvatarFaceBitmap(_arg_2);
                };
                _local_4.width = _local_4.bitmap.width;
                _local_4.height = _local_4.bitmap.height;
                _local_4.visible = true;
            };
        }

        private function onSearchEntry(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_2.id < 1)
            {
                return;
            };
            _friendList.view.showInfo(_arg_1, "${infostand.profile.link.tooltip}");
            if (_arg_1.type == "WME_OVER")
            {
                ExtendedProfileIcon.setUserInfoState(true, IWindowContainer(_arg_2.parent));
            }
            else
            {
                if (_arg_1.type == "WME_OUT")
                {
                    ExtendedProfileIcon.setUserInfoState(false, IWindowContainer(_arg_2.parent));
                }
                else
                {
                    if (_arg_1.type == "WME_CLICK")
                    {
                        _friendList.trackGoogle("extendedProfile", "friendList_friendsSearch");
                        _friendList.send(new GetExtendedProfileMessageComposer(_arg_2.id));
                    };
                };
            };
        }

        private function onSearchButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, "${friendlist.tip.search}");
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log(("Search clicked: " + _arg_2.name));
            searchAvatar();
        }

        private function onAskForFriendButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, "${friendlist.tip.addfriend}");
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            Logger.log(("Ask for friend clicked: " + _arg_2.id));
            var _local_3:HabboSearchResultData = this._friendList.searchResults.getResult(_arg_2.id);
            if (_local_3 == null)
            {
                Logger.log(("No search result found with id: " + _arg_2.id));
                return;
            };
            Logger.log(("Search result found: " + _local_3.avatarName));
            var _local_4:Boolean = this._friendList.askForAFriend(_local_3.avatarId, _local_3.avatarName);
            if (!_local_4)
            {
                _friendList.showLimitReachedAlert();
            }
            else
            {
                _friendList.showFriendRequestSentAlert(_local_3.avatarName);
                refreshEntry(true, findIndexFor(_local_3.avatarId), _local_3.avatarFigure, _local_3.avatarName, null, false, false, _local_3.avatarId);
            };
        }

        private function findIndexFor(_arg_1:int):int
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _SafeStr_853.numListItems)
            {
                if (_SafeStr_853.getListItemAt(_local_2).id == _arg_1)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        private function onChatButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, "${friendlist.tip.im}");
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            var _local_3:HabboSearchResultData = this._friendList.searchResults.getResult(_arg_2.id);
            if (_local_3 == null)
            {
                Logger.log(("No search result found with id: " + _arg_2.id));
                return;
            };
            _friendList.messenger.startConversation(_local_3.avatarId);
        }

        private function onSearchInput(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            _friendList.view.showInfo(_arg_1, "${friendlist.tip.searchstr}");
        }

        private function onSearchStrInput(_arg_1:WindowKeyboardEvent):void
        {
            var _local_2:int;
            var _local_4:String;
            var _local_5:IWindow = IWindow(_arg_1.target);
            Logger.log(((((("Test key event " + _arg_1) + ", ") + _arg_1.type) + " ") + _local_5.name));
            if (_arg_1.charCode == 13)
            {
                searchAvatar();
            }
            else
            {
                _local_2 = 25;
                _local_4 = _SafeStr_2473.text;
                if (_local_4.length > _local_2)
                {
                    _SafeStr_2473.text = _local_4.substring(0, _local_2);
                };
            };
        }

        private function searchAvatar():void
        {
            var _local_1:String = _SafeStr_2473.text;
            Logger.log(("Search avatar: " + _local_1));
            if (_local_1 == "")
            {
                Logger.log("No text...");
                return;
            };
            _friendList.send(new HabboSearchMessageComposer(_local_1));
        }


    }
}


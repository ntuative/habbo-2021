package com.sulake.habbo.utils
{
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    public class HabboWebTools 
    {

        public static const _SafeStr_4362:String = "advertisement";
        public static const _SafeStr_4363:String = "_self";
        public static const WINDOW_HABBO_MAIN:String = "habboMain";
        public static const OPEN_INTERNAL_LINK_FROM_WEB_CALLBACK:String = "openlink";
        public static const GOTO_ROOM_FROM_WEB_CALLBACK:String = "openroom";
        public static const HABBLET_AVATARS:String = "avatars";
        public static const HABBLET_MINI_MAIL:String = "minimail";
        public static const HABBLET_ROOM_ENTER_AD:String = "roomenterad";
        public static const HABBLET_NEWS:String = "news";

        private static var _SafeStr_4364:Boolean = false;
        private static var _SafeStr_3305:String;


        public static function set isSpaWeb(_arg_1:Boolean):void
        {
            _SafeStr_4364 = _arg_1;
        }

        public static function set baseUrl(_arg_1:String):void
        {
            _SafeStr_3305 = _arg_1;
        }

        public static function logEventLog(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.logEventLog", _arg_1);
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working, failed to log event log.");
            };
        }

        public static function openWebPage(_arg_1:String, _arg_2:String=""):void
        {
            var _local_3:String;
            if (((_arg_2 == null) || (_arg_2 == "")))
            {
                _arg_2 = "habboMain";
            };
            if (!ExternalInterface.available)
            {
                public::navigateToURL(_arg_1, _arg_2);
            }
            else
            {
                try
                {
                    _local_3 = ExternalInterface.call("function() {return navigator.userAgent;}").toLowerCase();
                    if (_local_3.indexOf("firefox") >= 0)
                    {
                        ExternalInterface.call("window.open", _arg_1, _arg_2);
                    }
                    else
                    {
                        if (_local_3.indexOf("msie") >= 0)
                        {
                            ExternalInterface.call((((("function setWMWindow() {window.open('" + _arg_1) + "', '") + _arg_2) + "');}"));
                        }
                        else
                        {
                            public::navigateToURL(_arg_1, _arg_2);
                        };
                    };
                }
                catch(e:Error)
                {
                    Logger.log("External interface not working, failed to open web page.");
                };
            };
        }

        public static function openPage(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openPage", _arg_1);
                }
                else
                {
                    public::navigateToURL(_arg_1, "habboMain");
                    Logger.log("External interface not available, openPage failed.");
                };
            }
            catch(e:Error)
            {
                Logger.log(("Failed to open web page " + _arg_1));
            };
        }

        public static function sendHeartBeat():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.heartBeat");
                };
            }
            catch(e:Error)
            {
            };
        }

        public static function openWebPageAndMinimizeClient(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        openPage(_arg_1);
                    }
                    else
                    {
                        public::navigateToURL(((_SafeStr_3305 + "/") + _arg_1), "habboMain");
                        ExternalInterface.call("FlashExternalInterface.openWebPageAndMinimizeClient", _arg_1);
                    };
                }
                else
                {
                    public::navigateToURL(((_SafeStr_3305 + "/") + _arg_1), "habboMain");
                    ExternalInterface.call("FlashExternalInterface.openWebPageAndMinimizeClient", _arg_1);
                };
            }
            catch(e:Error)
            {
                Logger.log(("Failed to open web page " + _arg_1));
            };
        }

        public static function closeWebPageAndRestoreClient():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.closeWebPageAndRestoreClient");
                };
            }
            catch(e:Error)
            {
                Logger.log("Failed to close web page and restore client!");
            };
        }

        public static function openWebHabblet(_arg_1:String, _arg_2:String=null):void
        {
            var _local_3:String;
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openHabblet", _arg_1, _arg_2);
                }
                else
                {
                    _local_3 = "";
                    switch (_arg_1)
                    {
                        case "avatars":
                            _local_3 = (_SafeStr_3305 + "/settings/avatars");
                            break;
                        case "news":
                            _local_3 = (_SafeStr_3305 + "/community/category/all/1/");
                            break;
                        default:
                            Logger.log(("Unknown habblet: " + _arg_1));
                    };
                    if (_local_3.length > 0)
                    {
                        public::navigateToURL(_local_3, "habboMain");
                    };
                };
            }
            catch(e:Error)
            {
                Logger.log(("Failed to open Habblet " + _arg_1));
            };
        }

        public static function closeWebHabblet(_arg_1:String, _arg_2:String=null):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.closeHabblet", _arg_1, _arg_2);
                };
            }
            catch(e:Error)
            {
                Logger.log(("Failed to close Habblet " + _arg_1));
            };
        }

        public static function sendDisconnectToWeb(_arg_1:int, _arg_2:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.disconnect", _arg_1, _arg_2);
                };
            }
            catch(e:Error)
            {
                Logger.log("Failed to close send ");
            };
        }

        public static function showGame(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalGameInterface.showGame", _arg_1);
                };
            }
            catch(e:Error)
            {
                Logger.log(("Failed to open game: " + e));
            };
        }

        public static function hideGame():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalGameInterface.hideGame");
                };
            }
            catch(e:Error)
            {
                Logger.log("Failed to hide game");
            };
        }

        public static function navigateToURL(_arg_1:String, _arg_2:String=null):void
        {
            if (((!(_arg_1)) || (_arg_1.length == 0)))
            {
                Logger.log("Can not navigate to empty url");
                return;
            };
            var _local_3:URLRequest = new URLRequest(_arg_1);
            flash.net.navigateToURL(_local_3, _arg_2); //not popped
        }

        public static function openExternalLinkWarning(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.openExternalLink", escape(_arg_1));
                }
                else
                {
                    public::navigateToURL(_arg_1, "habboMain");
                    Logger.log(("External interface not available. Could not request to open: " + _arg_1));
                };
            }
            catch(e:Error)
            {
                Logger.log(("External interface not working. Could not request to open: " + _arg_1));
            };
        }

        public static function roomVisited(_arg_1:int):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.roomVisited", _arg_1);
                }
                else
                {
                    Logger.log("External interface not available. Could not store last room visit.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not store last room visit.");
            };
        }

        public static function openMinimail(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.openMinimail", _arg_1);
                    }
                    else
                    {
                        openWebHabblet("minimail", _arg_1);
                    };
                }
                else
                {
                    openWebHabblet("minimail", _arg_1);
                    Logger.log("External interface not available. Could not open minimail.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not open minimail.");
            };
        }

        public static function openNews():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.openNews");
                    }
                    else
                    {
                        openWebHabblet("news");
                    };
                }
                else
                {
                    openWebHabblet("news");
                    Logger.log("External interface not available. Could not open news.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not open news.");
            };
        }

        public static function closeNews():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.closeNews");
                    }
                    else
                    {
                        closeWebHabblet("news");
                    };
                }
                else
                {
                    closeWebHabblet("news");
                    Logger.log("External interface not available. Could not close news.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not close news.");
            };
        }

        public static function openAvatars():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.openAvatars");
                    }
                    else
                    {
                        openWebHabblet("avatars");
                    };
                }
                else
                {
                    openWebHabblet("avatars");
                    Logger.log("External interface not available. Could not open avatars.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not open avatars.");
            };
        }

        public static function openRoomEnterAd():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.openRoomEnterAd");
                    }
                    else
                    {
                        openWebHabblet("roomenterad", "");
                    };
                }
                else
                {
                    openWebHabblet("roomenterad", "");
                    Logger.log("External interface not available. Could not open roomenterad.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not open roomenterad.");
            };
        }

        public static function updateFigure(_arg_1:String):void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    if (_SafeStr_4364)
                    {
                        ExternalInterface.call("FlashExternalInterface.updateFigure", _arg_1);
                    };
                }
                else
                {
                    Logger.log("External interface not available. Could not update figure.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not update figure.");
            };
        }

        public static function logOut():void
        {
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("FlashExternalInterface.logout");
                }
                else
                {
                    Logger.log("External interface not available. Could not logout.");
                };
            }
            catch(e:Error)
            {
                Logger.log("External interface not working. Could not logout.");
            };
        }


    }
}


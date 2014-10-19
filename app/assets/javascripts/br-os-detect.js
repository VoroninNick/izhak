// detect.js - browser & os detection
// 2011 (c) Ben Brooks Scholz. MIT Licensed.

;(function (window) {

    var browser,
        version,
        mobile,
        os,
        osversion,
        bit,
        ua = window.navigator.userAgent,
        platform = window.navigator.platform;

    if ( /MSIE/.test(ua) ) {

        browser = 'Internet Explorer';
        document.getElementsByTagName('body').className+= 'ie';

        if ( /IEMobile/.test(ua) ) {
            mobile = 1;
            document.getElementsByTagName('body').className+= 'ie-mobile';
        }

        version = /MSIE \d+[.]\d+/.exec(ua)[0].split(' ')[1];

    } else if ( /Chrome/.test(ua) ) {
        // Platform override for Chromebooks
        if ( /CrOS/.test(ua) ) {
            platform = 'CrOS';
            document.getElementsByTagName('body').className+= 'chrome-os';
        }

        browser = 'Chrome';
        version = /Chrome\/[\d\.]+/.exec(ua)[0].split('/')[1];
        document.getElementsByTagName('body').className+= 'chrome';

    } else if ( /Opera/.test(ua) ) {

        browser = 'Opera';
        document.getElementsByTagName('body').className+= 'opera';
        if ( /mini/.test(ua) || /Mobile/.test(ua) ) {
            document.getElementsByTagName('body').className+= 'opera-mobile';
            mobile = 1;
        }

    } else if ( /Android/.test(ua) ) {

        browser = 'Android Webkit Browser';
        mobile = 1;
        os = /Android\s[\.\d]+/.exec(ua)[0];

        document.getElementsByTagName('body').className+= 'andorid-webkit';

    } else if ( /Firefox/.test(ua) ) {

        browser = 'Firefox';
        document.getElementsByTagName('body').className+= 'firefox';

        if ( /Fennec/.test(ua) ) {
            mobile = 1;
            document.getElementsByTagName('body').className+= 'fennec-os';
        }
        version = /Firefox\/[\.\d]+/.exec(ua)[0].split('/')[1];

    } else if ( /Safari/.test(ua) ) {

        browser = 'Safari';
        document.getElementsByTagName('body').className+= 'safari';
        if ( (/iPhone/.test(ua)) || (/iPad/.test(ua)) || (/iPod/.test(ua)) ) {
            os = 'iOS';
            mobile = 1;
            document.getElementsByTagName('body').className+= 'ios-os';
        }

    }

    if ( !version ) {

        version = /Version\/[\.\d]+/.exec(ua);

        if (version) {
            version = version[0].split('/')[1];
        } else {
            version = /Opera\/[\.\d]+/.exec(ua)[0].split('/')[1];
        }

    }

    if ( platform === 'MacIntel' || platform === 'MacPPC' ) {
        os = 'Mac OS X';
        osversion = /10[\.\_\d]+/.exec(ua)[0];
        if ( /[\_]/.test(osversion) ) {
            osversion = osversion.split('_').join('.');
        }
        document.getElementsByTagName('body').className+= 'mac-os';
    } else if ( platform === 'CrOS' ) {
        os = 'ChromeOS';
        document.getElementsByTagName('body').className+= 'chrome-os';
    } else if ( platform === 'Win32' || platform == 'Win64' ) {
        os = 'Windows';
        bit = platform.replace(/[^0-9]+/,'');
        document.getElementsByTagName('body').className+= 'win-os';
    } else if ( !os && /Android/.test(ua) ) {
        os = 'Android';
        document.getElementsByTagName('body').className+= 'android-os';
    } else if ( !os && /Linux/.test(platform) ) {
        os = 'Linux';
        document.getElementsByTagName('body').className+= 'linux-os';
    } else if ( !os && /Windows/.test(ua) ) {
        os = 'Windows';
        document.getElementsByTagName('body').className+= 'win-os';
    }

    window.ui = {
        browser : browser,
        version : version,
        mobile : mobile,
        os : os,
        osversion : osversion,
        bit: bit
    };
}(this));

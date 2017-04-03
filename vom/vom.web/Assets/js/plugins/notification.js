function success_notification(message)
{
    setTimeout(function() {
        toastr.options = {
            closeButton: true,
            progressBar: true,
            preventDuplicates: true,
            showMethod: 'slideDown',
            timeOut: 5000
        };
        toastr.success(message);

    }, 1300);
}

function info_notification(message) {
    setTimeout(function () {
        toastr.options = {
            closeButton: true,
            progressBar: true,
            preventDuplicates: true,
            showMethod: 'slideDown',
            timeOut: 5000
        };
        toastr.info(message);

    }, 1300);
}

function warning_notification(message) {
    setTimeout(function () {
        toastr.options = {
            closeButton: true,
            progressBar: true,
            preventDuplicates: true,
            showMethod: 'slideDown',
            timeOut: 5000
        };
        toastr.warning(message);

    }, 1300);
}

function error_notification(message) {
    setTimeout(function () {
        toastr.options = {
            closeButton: true,
            progressBar: true,
            preventDuplicates: true,
            showMethod: 'slideDown',
            timeOut: 5000
        };
        toastr.error(message);

    }, 1300);
}
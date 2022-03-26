function show_emails(data) {
    my_ul_tag = $('#mu_ul')
    my_ul_tag.empty()
    var contacts = data.contacts;
    if (contacts) {
        for (const contact in contacts) {

            var li = document.createElement("li");
            var a = document.createElement('a');
            var linkText = document.createTextNode(contacts[contact].email);
            a.appendChild(linkText);
            a.title = contacts[contact].first_name;
            a.href = "/web_page/contactdetail/" + contacts[contact].pk;
            li.append(a)
            my_ul_tag.append(li)
        }

    } else {
        my_ul_tag.append()
    }

}

function send_ajax(input_data) {

    $.ajax({
        type: 'POST',
        url: "/web_page/search_contact/",
        dataType: 'json',
        data: {
            'csrfmiddlewaretoken': CSRF_TOKEN,
            'text': input_data
        },
        success: function (res) {
            show_emails(res)
        }
    });
}


$(document).ready(function () {

    $("#in_text").on("keyup", function () {

        send_ajax(this.value)
    });
});
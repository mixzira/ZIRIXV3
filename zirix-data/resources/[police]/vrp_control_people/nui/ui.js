$(function () {
    // Everest.getImage("GdgZthP", function (url) {
    //     $("#img_pessoa").attr("src", url.replace(".jpg", "l.jpg"));
    // });


    Everest.init();
});
var htmlOriginal = $(".body").html();
var time = 20000;
var bloq = false;
var passaporteAtual = 0;







var Everest = {}
Everest = {
    init: function () {
        Everest.setImage();
        window.addEventListener('message', function (event) {
            if (event.data.type === "abrirTablet") {
                $("#painel_control_people").fadeIn();
            }
            if (event.data.type === "fecharTablet") {
                $("#painel_control_people").fadeOut();
            }
            if (event.data.type === "setPassaporte") {
                passaporteAtual = event.data.identity.user_id;
                Everest.setPassaporte(event.data.identity, event.data.multas, event.data.emprego);
                // Swal.close();
            }
            if (event.data.type === "reloadPassaporte") {
                this.setTimeout(Everest.getPassaporte(), 500);
            }
            if (event.data.type === "setListaMultas") {
                Everest.setListaMultas(event.data.multas, false);
            }
            if (event.data.type === "setListaPrisoes") {
                Everest.getFichaCriminal(event.data.prisoes, false);
            }
            if (event.data.type === "getListaForagidos") {
                Everest.getListaForagidos(event.data.lista, false);
            }
            if (event.data.type === "getListaOcorrencias") {
                Everest.getListaOcorrencias(event.data.lista, false);
            }
        });

        document.onkeyup = function (data) {
            if (data.which == 27) {
                Everest.sendData("ButtonClick", { action: "fecharTablet" }, false);
            }
        }

        $("#painel_control_people .body").height($('#painel_control_people').height() - $(".header").height());
        window.onresize = function () {
            $("#painel_control_people .body").height($('#painel_control_people').height() - $(".header").height());
        }

        $('.modal').on('hidden.bs.modal', function () {
            $('.modal .modal-body').html("");
        });
    },
    getPassaporte: function () {
        var passaporte = $("input[name=passaporte]").val();

        if (passaporte === "") {

            $(".body").html("");
            return false;
        }
        Everest.sendData("ButtonClick", { action: "getPassaporte", passaporte: passaporte });
    },
    setPassaporte: function (identity, multas, emprego) {

        if (identity == null) {
            Everest.Alert("danger", "Passaporte inválido!", true);
            return false;
        }
        var dados = htmlOriginal;
        if (identity.foragido == 1) {
            dados = dados.replace("{NOME}", identity.name + " " + identity.firstname + " <span class=\"label label-default label-danger\">FORAGIDO</span>");
        } else {
            dados = dados.replace("{NOME}", identity.name + " " + identity.firstname);
        }

        dados = dados.replace("{PASSAPORTE}", identity.user_id);
        dados = dados.replace("{RG}", identity.registration);
        dados = dados.replace("{IDADE}", identity.age);
        dados = dados.replace("{TELEFONE}", identity.phone);
        dados = dados.replace("{TOTALMULTAS}", multas);
        dados = dados.replace("{FORAGIDO}", identity.foragido);
        dados = dados.replace("{PROFISSAO}", emprego == "" ? "Autônomo" : emprego);

        $("#painel_control_people .body").show();
        $(".body").html(dados);

        if (identity.foto) {
            $("#img_pessoa").attr("src", identity.foto.replace(".jpg", "l.jpg"));
        } else {
            $("#img_pessoa").attr("src", "img/nophoto.png");
        }

        Everest.setImage();
        Everest.AlertClose();
    },
    setImage: function () {
        var passaporte = passaporteAtual;
        $("#img_pessoa").click(function () {
            $("input[id='my_file']").click();
            return false;
        });

        $("input[id='my_file']").on("change", function () {

            var $files = $(this).get(0).files;

            if ($files.length) {

                // Reject big files
                if ($files[0].size > $(this).data("max-size") * 1024) {
                    console.log("Please select a smaller file");
                    return false;
                }

                // Replace ctrlq with your own API key
                var apiUrl = 'https://api.imgur.com/3/image';
                var apiKey = '9576bf13ee7a1fd';

                var settings = {
                    async: false,
                    crossDomain: true,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    url: apiUrl,
                    headers: {
                        Authorization: 'Client-ID ' + apiKey,
                        Accept: 'application/json'
                    },
                    mimeType: 'multipart/form-data'
                };

                Everest.Alert("info", "Aguarde...");

                setTimeout(function () {
                    var formData = new FormData();
                    formData.append("image", $files[0]);
                    // formData.append("album", "everest");
                    // formData.append("title", "Foto de perfil");
                    settings.data = formData;

                    // Response contains stringified JSON
                    // Image URL available at response.data.link

                    $.ajax(settings).done(function (response) {
                        var json = JSON.parse(response);

                        Everest.sendData("ButtonClick", { action: "updateFoto", foto: json.data.link, user_id: passaporte });
                        Everest.Alert("success", "Foto atualizada com sucesso!", true);
                    });
                }, 500);

            }
        });
    },
    getImage: function (img, rec) {
        $.ajax({
            type: "GET",
            url: "https://api.imgur.com/3/album/" + img + "/images",
            dataType: "text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'Client-ID 9576bf13ee7a1fd');
            },
            success: function (data) {
                var json = $.parseJSON(data);
                var links = json.data.map(function (item) {
                    rec(item.link);
                });
            }
        });
    },
    setMulta: function () {
        Swal.mixin({
            input: 'text',
            confirmButtonText: 'Próximo &rarr;',
            showCancelButton: true,
            progressSteps: ['1', '2', '3']
        }).queue([
            {
                title: 'Etapa 1',
                text: 'Informe o motivo da multa!',
                input: 'textarea',
            },
            {
                title: 'Etapa 2',
                text: 'Anexe uma imagem da multa!',
                input: 'file',
                inputAttributes: {
                    'accept': 'image/*',
                    'aria-label': 'Selecione a imagem'
                }
            },
            {
                title: 'Etapa 3',
                text: 'Informe o valor da multa!',
                input: 'number',
            },

        ]).then((result) => {
            Everest.Alert("info", "Aguarde...");

            setTimeout(function () {
                var passaporte = passaporteAtual;
                if (result.value[1] == null) {
                    Everest.Alert("success", "Multa aplicada com sucesso!", true);
                    Everest.sendData("ButtonClick", {
                        action: "setMulta",
                        passaporte: passaporte,
                        descricao: result.value[0].replace(/\r\n|\r|\n/g, "<br />"),
                        img: "",
                        valor: parseInt(result.value[2]),
                    }, true);

                    return false;
                }
                const reader = new FileReader();
                reader.onload = (e) => {
                    Everest.uploadImgur(e.target.result, function (img) {
                        Everest.Alert("success", "Multa aplicada com sucesso!", true);
                        Everest.sendData("ButtonClick", {
                            action: "setMulta",
                            passaporte: passaporte,
                            descricao: result.value[0],
                            img: img,
                            valor: parseInt(result.value[2]),
                        }, false);

                        return false;
                    });
                }
                reader.readAsDataURL(result.value[1]);
            }, 500);
        });
    },
    setOcorrencia: async function () {
        const { value: text } = await Swal.fire({
            input: 'textarea',
            inputPlaceholder: 'Escreva a ocorrência aqui!',
            inputAttributes: {
                'aria-label': 'Escreva a ocorrência aqui'
            },
            showCancelButton: true
        });

        Everest.Alert("info", "Aguarde...");

        setTimeout(function () {
            var passaporte = passaporteAtual;
            Everest.saveOcorrencia(passaporte, text, "");
        }, 500);
    },
    saveOcorrencia: function (passaporte, msg, img) {
        Everest.Alert("success", "Ocorrência efetuada com sucesso!", true);
        Everest.sendData("ButtonClick", {
            action: "setOcorrencia",
            passaporte: passaporte,
            descricao: msg.replace(/\r\n|\r|\n/g, "<br />"),
            img: img,
            valor: 0,
            pena: 0,
        }, false);
    },
    setPrisao: function () {
        Swal.mixin({
            input: 'text',
            confirmButtonText: 'Próximo &rarr;',
            showCancelButton: true,
            progressSteps: ['1', '2', '3', '4']
        }).queue([
            {
                title: 'Etapa 1',
                text: 'Informe detalhes da prisão!',
                input: 'textarea',
            },
            {
                title: 'Etapa 2',
                text: 'Anexe a foto do detento!',
                input: 'file',
                inputAttributes: {
                    'accept': 'image/*',
                    'aria-label': 'Selecione a imagem'
                }
            },
            {
                title: 'Etapa 3',
                text: 'Informe o valor da multa!',
                input: 'number',
            },
            {
                title: 'Etapa 4',
                text: 'Informe os meses  de prisão!',
                input: 'number',
                footer: 'No máximo 180 meses!'
            },

        ]).then((result) => {
            Everest.Alert("info", "Aguarde...");

            setTimeout(function () {
                var passaporte = passaporteAtual;
                if (result.value[1] == null) {
                    Everest.savePrisao(passaporte, result, null);
                }
                const reader = new FileReader();
                reader.onload = (e) => {
                    Everest.uploadImgur(e.target.result, function (img) {
                        Everest.savePrisao(passaporte, result, img);
                    });
                }
                if (result.value[1]) {
                    reader.readAsDataURL(result.value[1]);
                }
            }, 500);
        });
    },
    savePrisao: function (passaporte, result, img) {
        Everest.Alert("success", "Prisão efetuada com sucesso!", true);
        Everest.sendData("ButtonClick", {
            action: "setPrisao",
            passaporte: passaporte,
            descricao: result.value[0].replace(/\r\n|\r|\n/g, "<br />"),
            img: img,
            multa: parseInt(result.value[2]),
            pena: parseInt(result.value[3]),
        }, false);
    },

    setForagido: function (status) {

        var passaporte = passaporteAtual;

        var text = "Você está prestes a incluir este cidadão na lista de procurados!";
        if (status == 1) {
            text = "Remover da lista de procurados?";
        }

        Swal.fire({
            title: 'Atenção?',
            text: text,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            // cancelButtonColor: '#d33',
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Sim, continuar!'
        }).then(async (result) => {
            if (result.value) {
                if (status == 0) {
                    status = 1
                    const { value: text } = await Swal.fire({
                        title: 'Descreva o ocorrido',
                        input: 'textarea',
                        inputAttributes: {
                            max: 250
                        },
                        showCancelButton: true,
                        confirmButtonText: 'Registrar',
                        showLoaderOnConfirm: true,
                    });
                    if (text != null) {
                        Everest.Alert("success", "Foi incluído na lista de foragidos!", true);
                        setTimeout(function () {
                            Everest.sendData("ButtonClick", {
                                action: "setForagido",
                                passaporte: passaporte,
                                descricao: text.replace(/\r\n|\r|\n/g, "<br />"),
                                img: "",
                                multa: 0,
                                valor: status,
                            }, false);
                        }, 500);
                    }
                } else {
                    status = 0
                    Everest.Alert("success", "Foi removido da lista de foragidos!", true);
                    setTimeout(function () {
                        Everest.sendData("ButtonClick", {
                            action: "setForagido",
                            passaporte: passaporte,
                            descricao: text.replace(/\r\n|\r|\n/g, "<br />"),
                            img: "",
                            multa: 0,
                            valor: status,
                        }, false);
                    }, 500);
                }
            }
        });
    },
    uploadImgur: function (file, upload) {
        // Replace ctrlq with your own API key
        var apiUrl = 'https://api.imgur.com/3/image';
        var apiKey = '9576bf13ee7a1fd';

        var settings = {
            async: false,
            crossDomain: true,
            processData: false,
            contentType: false,
            type: 'POST',
            dataType: 'json',
            url: apiUrl,
            headers: {
                Authorization: 'Client-ID ' + apiKey,
                Accept: 'application/json'
            },
            // mimeType: 'multipart/form-data'
        };

        var formData = new FormData();
        file = file.replace('data:image/jpeg;base64,', "");
        file = file.replace('data:image/png;base64,', "");
        formData.append("image", file);
        settings.data = formData;

        // Response contains stringified JSON
        // Image URL available at response.data.link
        Everest.Alert("info", "Aguarde...");
        $.ajax(settings).done(function (json) {
            upload(json.data.link);
        });

    },
    getFichaCriminal: function (prisoes, request) {
        var htmlprisoes = '<div class="row" id="multa_{ID}">' +
            '<div class="col-sm-12">' +
            '<div class="thumbnail">' +
            '{IMG}' +
            '<div class="caption">' +
            '<strong>Pena:</strong> {PENA} meses ' +
            '<br><strong>Motivo:</strong> {MOTIVO}' +
            '<br><strong>Oficial:</strong> {POLICIAL}' +
            '<br><strong>Data:</strong> {DATA}' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>';



        if (request) {
            var passaporte = passaporteAtual;
            Everest.sendData("ButtonClick", { action: "getPrisoes", passaporte: passaporte }, true);
        } else {
            if (prisoes.length == 0) {
                Everest.newModal("Ficha Criminal", "<strong>Nada Encontrado</strong>");
            } else {
                var htmlAux = "";
                $(prisoes).each(function (index, data) {
                    var html = htmlprisoes;

                    html = html.replace("{ID}", index);
                    html = html.replace("{PENA}", parseInt(data.valor));
                    html = html.replace("{MOTIVO}", data.dvalue);
                    html = html.replace("{POLICIAL}", data.name + " " + data.firstname);
                    html = html.replace("{DATA}", data.datahora);
                    if (data.img != null && data.img != "") {
                        html = html.replace("{IMG}", '<img src="' + data.img + '" />');
                    }else {
                        html = html.replace("{IMG}", "");
                    }

                    htmlAux += html;
                });
                Everest.newModal("Ficha Criminal", htmlAux);
            }
        }
    },
    setListaMultas: function (multas, request) {

        if (request) {
            var passaporte = passaporteAtual;
            Everest.sendData("ButtonClick", { action: "getMultas", passaporte: passaporte }, true);
        } else {
            Everest.AlertClose();
            
            if (multas.length == 0) {
                Everest.newModal("Multas", "<strong>Nada Encontrado</strong>");
            } else {
                var htmlAux = "";
                $(multas).each(function (index, data) {
                    var html = '<div class="row" id="multa_{ID}">' +
                    '<div class="col-sm-12">' +
                    '<div class="thumbnail">' +
                    '{IMG}' +
                    '<div class="caption">' +
                    '<strong>Valor:</strong> $ {VALOR}' +
                    '<br><strong>Motivo:</strong> {MOTIVO}' +
                    '<br><strong>Oficial:</strong> {POLICIAL}' +
                    '<br><strong>Data:</strong> {DATA}' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';

                    html = html.replace("{ID}", index);
                    html = html.replace("{VALOR}", data.valor);
                    html = html.replace("{MOTIVO}", data.dvalue);
                    html = html.replace("{POLICIAL}", data.name + " " + data.firstname);
                    html = html.replace("{DATA}", data.datahora);
                    if (data.img != null && data.img != "") {
                        html = html.replace("{IMG}", '<img src="' + data.img + '" />');
                    }else {
                        html = html.replace("{IMG}", "");
                    }

                    htmlAux += html;
                });
                Everest.newModal("Multas", htmlAux);
            }
            // Swal.close();
        }
    },

    getListaForagidos: function (multas, request) {

        if (request) {
            Everest.sendData("ButtonClick", { action: "getListaForagidos" }, true);
        } else {
            Everest.AlertClose();

            if (multas.length == 0) {
                Everest.newModal("Foragidos", "<strong>Nada Encontrado</strong>");
            } else {
                var htmlAux = "";
                $(multas).each(function (index, data) {
                    var html = '<div class="row" id="multa_{ID}">' +
                        '<div class="col-sm-4">' +
                        '<div class="thumbnail">' +
                        '{IMG}' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-sm-8">' +
                        '<strong>Nome:</strong> {NOME_FORAGIDO}' +
                        '<br><strong>Motivo:</strong> {MOTIVO}' +
                        '<br><strong>Oficial Responsável:</strong> {POLICIAL}' +
                        '<br><strong>Data:</strong> {DATA}' +
                        '</div>' +
                        '</div><div class="row"><div class="col-sm-12"><hr></div></div>';

                    html = html.replace("{ID}", index);
                    html = html.replace("{NOME_FORAGIDO}", data.nomeForagido + " " + data.sobrenomeForagido + " " + data.user_id);
                    html = html.replace("{MOTIVO}", data.dvalue);
                    html = html.replace("{POLICIAL}", data.nomePolicia + " " + data.sobrenomePolicia);
                    html = html.replace("{DATA}", data.datahora);
                    if (data.foto != null && data.foto != "") {
                        html = html.replace("{IMG}", '<img src="' + data.foto + '" />');
                    } else {
                        html = html.replace("{IMG}", "");
                    }

                    htmlAux += html;
                });
                Everest.newModal("Foragidos", htmlAux);
            }


            // Swal.close();
        }
    },

    getListaOcorrencias: function (multas, request, passaporte) {

        if (request) {
            Everest.sendData("ButtonClick", { action: "getListaOcorrencias", passaporte: passaporte}, true);
        } else {
            Everest.AlertClose();

            if (multas.length == 0) {
                Everest.newModal("Ocorrências", "<strong>Nada Encontrado</strong>");
            } else {
                var htmlAux = "";
                $(multas).each(function (index, data) {
                    var html = '<div class="row" id="multa_{ID}">' +
                        '<div class="col-sm-4">' +
                        '<div class="thumbnail">' +
                        '{IMG}' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-sm-8">' +
                        '<strong>Nome:</strong> {NOME_FORAGIDO}' +
                        '<br>{MOTIVO}' +
                        '<br><strong>Oficial Responsável:</strong> {POLICIAL}' +
                        '<br><strong>Data:</strong> {DATA}' +
                        '</div>' +
                        '</div><div class="row"><div class="col-sm-12"><hr></div></div>';

                    html = html.replace("{ID}", index);
                    html = html.replace("{NOME_FORAGIDO}", data.nomeForagido + " " + data.sobrenomeForagido + " " + data.user_id);
                    html = html.replace("{MOTIVO}", data.dvalue);
                    html = html.replace("{POLICIAL}", data.nomePolicia + " " + data.sobrenomePolicia);
                    html = html.replace("{DATA}", data.datahora);
                    if (data.foto != null && data.foto != "") {
                        html = html.replace("{IMG}", '<img src="' + data.foto + '" />');
                    } else {
                        html = html.replace("{IMG}", '<img src="img/nophoto.png" />');
                    }

                    htmlAux += html;
                });
                Everest.newModal("Ocorrências", htmlAux);
            }


            // Swal.close();
        }
    },

    Alert: function (type, msg, bloquear) {
        if (bloq == false) {
            bloq = (bloquear == null ? false : bloquear);

            $("#alert").html(msg).removeClass().addClass(type).fadeIn();

            setTimeout(function () {
                $("#alert").fadeOut();
                bloq = false;
            }, 10000);
        }
    },
    AlertClose: function () {

        setTimeout(function () {
            if (bloq === false) {
                $("#alert").fadeOut();
            }
        }, 500);

    },
    sendData: function (name, data, load) {
        var time = 0;
        if (load !== false) {
            Everest.Alert("info", "Aguarde...");
            time = 500;
        }
        setTimeout(function () {
            $.post("http://vrp_control_people/" + name, JSON.stringify(data));
        }, time);
    },
    newModal:function(title, html) {
        var random = Math.floor((Math.random() * 100) + 1);
        var modalHtml = '<div class="modal fade" tabindex="-1" role="dialog" id="modal'+random+'">'+
                        '<div class="modal-dialog modal-md" role="document">'+
                            '<div class="modal-content">'+
                            '<div class="modal-header">'+
                                '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
                                    '<h4 class="modal-title">'+title+'</h4>'+
                                    '</div>'+
                                '<div class="modal-body">'+html+'</div>'+
                                '</div>'+
                            '</div>'+
                        '</div>';

        $("#modals").append(modalHtml);
        $('#modal'+random).modal("show");
        $('#modal'+random).on('hidden.bs.modal', function () {
            $(this).remove();
        });
    }
}

function imgMD(img) {
    img = img.replace(".jpg", "l.jpg");
    img = img.replace(".png", "l.png");

    return img;
}
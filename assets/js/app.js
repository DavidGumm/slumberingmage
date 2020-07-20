// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

require("../css/app.css");

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

const removeElement = ({ target }) => {
    let el = document.getElementById(target.dataset.id);
    let li = el.parentNode;
    li
        .parentNode
        .removeChild(li)

    Array
        .from(document.querySelectorAll('.remove-form-field'))
        .forEach(el => {
            el.onclick = (e) => {
                removeElement(e)
            }
        });
    Array
        .from(document.querySelectorAll('.add-form-field'))
        .forEach(el => {
            el.onclick = ({ target }) => {
                let container = document.getElementById(target.dataset.container);
                let index = container.dataset.index;
                let newRow = target.dataset.prototype;
                container.insertAdjacentHTML('beforeend', newRow.replace(/__name__/g, index));
                container.dataset.index = parseInt(container.dataset.index) + 1;
                container
                    .querySelectorAll('a.remove-form-field')
                    .forEach(el => {
                        el.onclick = (e) => {
                            removeElement(e)
                        }
                    })
            }
        })
}

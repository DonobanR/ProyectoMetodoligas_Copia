package incrementos;

public class Pago {

    private VerificarPagoGateway gateway;

    private int saldoDisponible;

    public Pago(int saldoDisponible, VerificarPagoGateway gateway) {
        this.saldoDisponible = saldoDisponible;
        this.gateway = gateway;
    }

    public void realizarPago(double monto) throws SaldoInsuficienteException {
        if (monto > this.saldoDisponible) {
            throw new SaldoInsuficienteException("Saldo insuficiente para realizar el pago");
        }else{
            this.saldoDisponible -= monto;
            System.out.println("Pago realizado com sucesso");
        }
    }

    public Pago(VerificarPagoGateway gateway) {
        this.gateway = gateway;
    }

    public boolean verificarPago(boolean validOrInvalid){
        VerificarPagoResponse response =
                gateway.requestVerificarPago(new VerificarPagoRequest(validOrInvalid));

        if(response.getStatus() == VerificarPagoResponse.TargetStatus.VALIDA){
            return true;
        } else {
            return false;
        }
    }

    public boolean verificarPagoInvalid(boolean validOrInvalid){
        VerificarPagoResponse response =
                gateway.requestVerificarPago(new VerificarPagoRequest(validOrInvalid));

        if(response.getStatus() == VerificarPagoResponse.TargetStatus.INVALIDA){
            return false;
        } else {
            return true;
        }
    }

}
